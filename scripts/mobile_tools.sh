#!/data/data/com.termux/files/usr/bin/bash

set -euo pipefail

# Colors
CYN='\033[1;36m'
GRN='\033[1;32m'
YLW='\033[1;33m'
RED='\033[1;31m'
R='\033[0m'

# ── Safe Permission Layer ───────────────────
confirm_action() {
    echo -ne "${YLW}$1 (y/n): ${R}"
    read -r confirm
    [[ "$confirm" == "y" || "$confirm" == "Y" ]]
}

# ── Safe Commands Only ──────────────────────

case "${1:-}" in

    "status")
        echo -e "${CYN}--- System Status ---${R}"
        termux-battery-status | grep -E 'percentage|status'
        termux-wifi-connectioninfo | grep -E 'ssid'
        ;;

    "notify")
        if confirm_action "Send notification?"; then
            termux-notification -t "BossAI" -c "${2:-Hello}" --priority high
            echo "✔ Notification sent"
        fi
        ;;

    "vibrate")
        if confirm_action "Vibrate phone?"; then
            termux-vibrate -d ${2:-300}
            echo "✔ Vibrated"
        fi
        ;;

    "speak")
        if confirm_action "Use text-to-speech?"; then
            termux-tts-speak "${2:-Hello from AI}"
            echo "✔ Spoken"
        fi
        ;;

    "camera_snap")
        if confirm_action "Take a photo?"; then
            file="${2:-photo.jpg}"
            termux-camera-photo -c 0 "$file"
            echo "✔ Saved: $file"
        fi
        ;;

    # ── Removed dangerous features ──
    # ❌ sms
    # ❌ ui control (tap/swipe)
    # ❌ adb/rish escalation
    # ❌ open_app

    *)
        echo "Usage:"
        echo "  status            → device info"
        echo "  notify <msg>      → send notification"
        echo "  vibrate <ms>      → vibrate phone"
        echo "  speak <text>      → text-to-speech"
        echo "  camera_snap       → take photo"
        ;;
esac