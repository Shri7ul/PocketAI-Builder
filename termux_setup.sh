#!/data/data/com.termux/files/usr/bin/bash

# ── Strict Mode (safer bash) ─────────────────
set -euo pipefail

# ── Colors & Config ──────────────────────────
CYN='\033[1;36m'
GRN='\033[1;32m'
YLW='\033[1;33m'
RED='\033[1;31m'
B='\033[1m'
R='\033[0m'
LAUNCHER="$PREFIX/bin/claude"

# ── UI Header ────────────────────────────────
header() {
    clear
    echo -e "${CYN}${B}BossAI-Lab Setup (Ollama Edition)${R}"
    echo "───────────────────────────────────────────"
}

# ── Confirm Action (NEW safety layer) ────────
confirm_action() {
    echo -ne "${YLW}$1 (y/n): ${R}"
    read -r confirm
    [[ "$confirm" == "y" || "$confirm" == "Y" ]]
}

# ── Ollama Validation ────────────────────────
check_ollama_status() {
    echo -e "\n${CYN}Checking Ollama Server...${R}"

    if ! command -v ollama &> /dev/null; then
        echo -e "${RED}✖ Ollama is not installed!${R}"
        echo -e "Run: ${YLW}pkg install ollama${R}"
        exit 1
    fi

    if ! curl -s http://localhost:11434/api/tags &> /dev/null; then
        echo -e "${RED}✖ Ollama server is NOT running!${R}"
        echo -e "Run in another tab: ${YLW}ollama serve${R}"
        exit 1
    fi

    echo -e "${GRN}✔ Ollama Server is live.${R}"
}

# ── Model Selection (safe input handling) ────
select_ollama_model() {
    echo -e "\n${B}Select an Ollama Model:${R}"
    echo "───────────────────────────────────────────"

    MODELS=(
        "llama3"
        "mistral"
        "gemma"
        "qwen"
    )

    for i in "${!MODELS[@]}"; do
        echo -e "${CYN}$((i+1)))${R} ${MODELS[$i]}"
    done
    echo -e "${YLW}$(( ${#MODELS[@]} + 1 )))${R} Custom Model"

    while true; do
        echo -ne "\nChoose [1-$(( ${#MODELS[@]} + 1 ))]: "
        read -r choice

        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#MODELS[@]} + 1 )); then
            break
        else
            echo -e "${RED}Invalid choice. Try again.${R}"
        fi
    done

    if (( choice == ${#MODELS[@]} + 1 )); then
        read -r -p "Enter model name: " SELECTED_MODEL
    else
        SELECTED_MODEL=${MODELS[$((choice-1))]}
    fi

    echo -e "\n${GRN}Selected model:${B} $SELECTED_MODEL${R}"

    if confirm_action "Pull model now? (requires internet)"; then
        ollama pull "$SELECTED_MODEL"
    else
        echo -e "${YLW}Skipping model download.${R}"
    fi
}

# ── Launcher Generation ──────────────────────
generate_ollama_launcher() {
    cat << EOF > "$LAUNCHER"
#!/data/data/com.termux/files/usr/bin/bash

# BossAI Local Runner
export CLAUDE_CODE_USE_OPENAI=1
export OPENAI_API_KEY="ollama"
export OPENAI_BASE_URL="http://localhost:11434/v1"
export OPENAI_MODEL="$SELECTED_MODEL"

# Safe execution (limited bind)
proot -b \$HOME:/home -b /sdcard openclaude "\$@"
EOF

    chmod +x "$LAUNCHER"
}

# ── Dependency Installation ──────────────────
install_dependencies() {
    echo -e "\n${CYN}Installing Dependencies...${R}"

    if confirm_action "Install required packages (nodejs, git, etc.)?"; then
        pkg update -y
        pkg install nodejs git curl proot termux-api -y
    else
        echo -e "${RED}Skipping dependencies may break setup.${R}"
    fi

    if confirm_action "Install OpenClaude (npm)?"; then
        npm install -g @gitlawb/openclaude
    fi
}

# ── Main Execution ───────────────────────────
header
check_ollama_status
select_ollama_model
install_dependencies
generate_ollama_launcher

echo -e "\n${GRN}${B}Setup Complete!${R}"
echo -e "Run '${CYN}claude${R}' to start your local AI 🚀"