import tkinter as tk
from tkinter import messagebox

def get_button(window, text, color, command, fg="white"):
    button = tk.Button(
        window,
        text=text,
        bg=color,
        fg=fg,
        activebackground="#1e1e1e",  # Darker on hover
        activeforeground="white",
        command=command,
        font=('Segoe UI', 16, 'bold'),  # Modern Windows font
        padx=20,
        pady=10,
        borderwidth=0,
        relief="flat",
        cursor="hand2"
    )
    return button

def get_img_label(window):
    label = tk.Label(window, bg="black")  # Webcam frame background black
    label.place(x=20, y=20, width=700, height=500)  # Fixed webcam box size
    return label

def get_text_label(window, text):
    label = tk.Label(
        window,
        text=text,
        font=("Segoe UI", 18, "bold"),
        fg="white",
        bg="#2d2d2d",
        anchor="w",
        padx=10,
        pady=10
    )
    return label

def get_entry_text(window):
    inputtxt = tk.Text(
        window,
        height=2,
        width=20,
        font=("Segoe UI", 18),
        bg="#1e1e1e",
        fg="white",
        insertbackground="white",
        relief="flat"
    )
    return inputtxt

def msg_box(title, description):
    messagebox.showinfo(title, description)
