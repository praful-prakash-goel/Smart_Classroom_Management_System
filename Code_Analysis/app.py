from flask import Flask, request, render_template
import os
import subprocess
import ast
from ollama import Client
from flask_cors import CORS

app = Flask(__name__)
CORS(app, supports_credentials=True)

UPLOAD_FOLDER = os.path.join(os.getcwd(), 'uploads')
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

ollama_client = Client(host='http://localhost:11434')

@app.route('/api/code-analysis', methods=['POST'])
@app.route('/api/code-analysis', methods=['POST'])
def index():
    feedback = None
    uploaded_file = request.files.get('file')
    problem_statement = request.form.get('problem')

    if not uploaded_file or uploaded_file.filename == '':
        feedback = 'No file uploaded.'
    else:
        file_path = os.path.join(UPLOAD_FOLDER, uploaded_file.filename)
        uploaded_file.save(file_path)

        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            code_content = f.read()

        extension = os.path.splitext(uploaded_file.filename)[1].lower()
        ai_feedback = analyze_code_with_ollama(problem_statement, code_content)

        if extension == '.py':
            syntax_feedback = check_python_syntax(code_content)
        elif extension == '.c':
            syntax_feedback = check_c_syntax(file_path)
        elif extension == '.java':
            syntax_feedback = check_java_syntax(file_path)
        elif extension == '.cpp':
            syntax_feedback = check_cpp_syntax(file_path)
        else:
            syntax_feedback = "Syntax checking not available for this file type."

        indentation_feedback = check_indentation(code_content)

        feedback = f"""
<strong> Problem Statement:</strong><br>{problem_statement}<br><br>
<strong> AI Detection:</strong><br>{ai_feedback}<br><br>
<strong> Syntax Feedback:</strong><br>{syntax_feedback}<br><br>
<strong> Indentation Feedback:</strong><br>{indentation_feedback}
"""

    return f"<html><body><div class='report'>{feedback}</div></body></html>"


def analyze_code_with_ollama(problem, code):
    try:
        prompt = f"""
You are an experienced programming teacher and AI-detection expert. Evaluate the student's submitted code **strictly from a teacher's perspective**.

 **Do NOT provide:**
- Corrected code
- Suggested improvements
- Rewritten versions

 **Provide:**
1. **Problem Solving Accuracy:** Yes or No with one-line justification.
2. **Code Readability:** Good, Average, or Poor with one-line justification.
3. **AI-Generated Likelihood:** AI-Generated, Student-Written, or Uncertain with a strong and clear justification.

Problem Statement:
{problem}

Code:
{code}
"""
        response = ollama_client.chat(model="llama3.2:latest", messages=[
            {"role": "user", "content": prompt}
        ])
        return response['message']['content']
    except Exception as e:
        return f" Error during LLaMA feedback: {e}"

def check_python_syntax(code):
    try:
        ast.parse(code)
        return " No syntax errors detected (Python)."
    except SyntaxError as e:
        return f" Python Syntax Error: {e}"

def check_c_syntax(file_path):
    try:
        result = subprocess.run(['gcc', '-fsyntax-only', file_path], capture_output=True, text=True)
        return " No syntax errors detected (C)." if result.returncode == 0 else f" C Syntax Error:\n{result.stderr}"
    except Exception as e:
        return f" Error during C syntax check: {e}"

def check_java_syntax(file_path):
    try:
        result = subprocess.run(['javac', file_path], capture_output=True, text=True)
        return " No syntax errors detected (Java)." if result.returncode == 0 else f" Java Syntax Error:\n{result.stderr}"
    except Exception as e:
        return f" Error during Java syntax check: {e}"

def check_cpp_syntax(file_path):
    try:
        result = subprocess.run(['g++', '-fsyntax-only', file_path], capture_output=True, text=True)
        return " No syntax errors detected (C++)." if result.returncode == 0 else f" C++ Syntax Error:\n{result.stderr}"
    except Exception as e:
        return f" Error during C++ syntax check: {e}"

def check_indentation(code):
    lines = code.splitlines()
    bad_lines = []
    for i, line in enumerate(lines):
        if line.startswith(" ") and (len(line) - len(line.lstrip())) % 4 != 0:
            bad_lines.append(f"Line {i + 1}: Suspect indentation.")
    return " Indentation looks consistent." if not bad_lines else "\n".join(bad_lines)

if __name__ == '__main__':
    app.run(debug=True, port=5002)
