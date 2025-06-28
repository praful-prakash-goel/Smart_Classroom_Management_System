import React, { useState, useRef, useEffect } from "react";
import knowlioStyles from "../styles/Knowlio.module.css";
import knowlioLogo from "../assets/Knowlio_white.png";
import sendButton from "../assets/send-arrow.png";
import ReactMarkdown from 'react-markdown';

const Knowlio = () => {
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState("");
  const [chatStarted, setChatStarted] = useState(false);
  const [isTyping, setIsTyping] = useState(false);
  const chatRef = useRef(null);

  const handleSend = async () => {
    if (!input.trim()) return;

    setChatStarted(true);
    const userMessage = { text: input, type: "user" };
    setMessages(prev => [...prev, userMessage]);
    setInput("");
    setIsTyping(true);

    try {
      const response = await fetch("http://127.0.0.1:5000/chat", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: JSON.stringify({ message: input }),
        mode: "cors"
      });

      if (!response.ok) throw new Error(`Server error: ${response.status}`);

      const data = await response.json();
      const botMessage = {
        text: data.response || "No response received.",
        type: "bot"
      };
      setMessages(prev => [...prev, botMessage]);
    } catch (error) {
      console.error("Error:", error);
      setMessages(prev => [...prev, { text: "Error: Unable to get response.", type: "bot" }]);
    } finally {
      setIsTyping(false);
    }
  };

  useEffect(() => {
    chatRef.current?.scrollTo({ top: chatRef.current.scrollHeight, behavior: "smooth" });
  }, [messages]);

  return (
    <div className={knowlioStyles.container}>
      <header className={knowlioStyles.header}>
        <img src={knowlioLogo} alt="Knowlio Logo" className={knowlioStyles.logo} />
      </header>
      <main className={knowlioStyles.chatWrapper}>
        {!chatStarted && (
          <div className={knowlioStyles.centerPrompt}>
            <h1 className={knowlioStyles.title}>What can I help with?</h1>
            <div className={knowlioStyles.inputContainer}>
              <input
                type="text"
                className={knowlioStyles.inputBox}
                placeholder="Ask anything..."
                value={input}
                onChange={(e) => setInput(e.target.value)}
                onKeyDown={(e) => e.key === "Enter" && handleSend()}
              />
              <img
                src={sendButton}
                alt="Send"
                className={knowlioStyles.sendButton}
                onClick={handleSend}
              />
            </div>
          </div>
        )}

        {chatStarted && (
          <>
            <div className={knowlioStyles.messageContainer} ref={chatRef}>
              {messages.map((msg, index) => (
                <div
                  key={index}
                  className={`${knowlioStyles.message} ${
                    msg.type === "user" ? knowlioStyles.userMessage : knowlioStyles.botMessage
                  }`}
                >
                  {msg.type === 'bot' ? (
                    <ReactMarkdown>{msg.text}</ReactMarkdown>
                  ) : (
                    msg.text
                  )}
                </div>
              ))}
              {isTyping && (
                <div className={`${knowlioStyles.message} ${knowlioStyles.botMessage}`}>
                  <div className={knowlioStyles.typingDots}>
                    <span></span>
                    <span></span>
                    <span></span>
                  </div>
                </div>
              )}
            </div>

            <div className={knowlioStyles.inputContainer}>
              <input
                type="text"
                className={knowlioStyles.inputBox}
                placeholder="Ask anything..."
                value={input}
                onChange={(e) => setInput(e.target.value)}
                onKeyDown={(e) => e.key === "Enter" && handleSend()}
              />
              <img
                src={sendButton}
                alt="Send"
                className={knowlioStyles.sendButton}
                onClick={handleSend}
              />
            </div>
          </>
        )}
      </main>
    </div>
  );
};

export default Knowlio;
