Simple vulnerable-ish app for demo purposes only.
from flask import Flask, request, jsonify

app = Flask(__name__)

# NOTE: This is a demo app. Do not use as-is in production.
@app.get("/")
def index():
    return jsonify({"message": "Hello, Secure World!"})

# Example of input handling (kept very simple for SAST to inspect)
@app.post("/echo")
def echo():
    data = request.get_json(silent=True) or {}
    # Potentially untrusted input echoed back
    return jsonify({"you_sent": data})

if __name__ == "__main__":
    # Bind to all interfaces for Docker container; debug disabled
    app.run(host="0.0.0.0", port=5000, debug=False)
