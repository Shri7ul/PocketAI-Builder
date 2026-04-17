# 🚀 POCKETAI-BUILDER

A lightweight, local-first AI development assistant built for mobile using Termux.
Build websites, automate tasks, and experiment with AI — right from your phone.

---

## ✨ Features

* 🧠 **Local AI Support (Optional)**
  Run models locally using Ollama *(optional)*

* ⚡ **API Mode (Recommended)**
  Use fast cloud models like Gemini / OpenRouter

* 📱 **Mobile Dev Environment**
  Full AI-powered coding setup inside Termux

* 🛠 **Hardware Integration (Safe Mode)**
  Control basic phone features like:

  * Notifications
  * Camera
  * Vibration
  * Text-to-Speech

* 🔐 **Security First**

  * No silent permission abuse
  * No auto-execution
  * Full user control

---

## 🛠 Prerequisites

Install the following:

* Termux (F-Droid / GitHub version only)
* Termux:API

> ⚠️ Do NOT use Play Store version of Termux

---

## ⚙️ Setup Guide (Phone)

### 1️⃣ Basic Setup

```bash
termux-setup-storage
pkg update && pkg upgrade -y
pkg install git nodejs curl proot -y
```

---

### 2️⃣ Clone Repository

```bash
git https://github.com/Shri7ul/PocketAI-Builder
cd PocketAI-Builder
```

---

### 3️⃣ Run Setup Script

```bash
chmod +x termux_setup.sh
bash termux_setup.sh
```

---

### 4️⃣ Start AI Assistant

```bash
claude
```

---

## 🤖 Usage

Example:

```bash
claude
```

Then ask:

> Create a Tic Tac Toe game using HTML, CSS, and JavaScript

Copy the output and run it in your browser.

---

## 🌐 Running Your Projects

Save files inside your project folder:

```bash
nano index.html
```

Run using:

```bash
npx serve .
```

Then open:

```
http://localhost:3000
```

---

## ⚙️ Optional Features

### 🔹 Shizuku (Advanced Only)

Use only if you need:

* UI automation
* system-level interaction

Otherwise:

> ❌ Not required

---

## 🚫 Security Notice

* Do NOT run unknown scripts
* Avoid one-line installers from random sources
* Always review code before execution

---

## 🧠 Recommended Setup

| Mode                    | Use Case          |
| ----------------------- | ----------------- |
| API (Gemini/OpenRouter) | Fast + Smart      |
| Local (Ollama)          | Offline + Private |

---

## 📌 Project Structure

```
BossAI-Lab/
├── termux_setup.sh
├── scripts/
│   ├── mobile_tools.sh
│   └── setup_shizuku.sh
├── pc_push_installation.ps1
├── windows_setup.bat
```

---

## 💼 Author

**Shriful Islam (InHuman)**    
AI | Automation | Creative Engineering

---

## ⭐ Support

If you find this useful:

* ⭐ Star the repo
* 🔁 Share with others

---

## ⚡ Future Plans

* Web UI dashboard
* Plugin system
* Voice assistant integration

---

> Built with curiosity, not just code.
