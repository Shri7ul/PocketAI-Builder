#!/data/data/com.termux/files/usr/bin/bash

set -euo pipefail

CYN='\033[1;36m'
GRN='\033[1;32m'
YLW='\033[1;33m'
RED='\033[1;31m'
R='\033[0m'

echo -e "${CYN}🤖 Shizuku Setup (Safe Mode)${R}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ── Confirm before proceeding ───────────────
read -p "Do you want to enable Shizuku integration? (y/n): " confirm
if [[ "$confirm" != "y" ]]; then
    echo "Skipped Shizuku setup."
    exit 0
fi

# ── Storage permission ──────────────────────
if [ ! -d "$HOME/storage" ]; then
    echo "Grant storage permission..."
    termux-setup-storage
    sleep 3
fi

SHIZUKU_DIR="$HOME/storage/shared/Shizuku"
BIN="$PREFIX/bin"

# ── Check files ─────────────────────────────
if [ ! -f "$SHIZUKU_DIR/rish" ] || [ ! -f "$SHIZUKU_DIR/rish_shizuku.dex" ]; then
    echo -e "${RED}❌ Shizuku files not found!${R}"
    echo "Open Shizuku → Export files → Save to /Shizuku"
    exit 1
fi

echo -e "${YLW}Copying Shizuku binaries...${R}"

cp -f "$SHIZUKU_DIR/rish" "$BIN/rish"
cp -f "$SHIZUKU_DIR/rish_shizuku.dex" "$BIN/rish_shizuku.dex"

# Fix line endings
sed -i 's/\r$//' "$BIN/rish"

# Add app ID safely (only if not exists)
grep -q RISH_APPLICATION_ID "$BIN/rish" || \
sed -i '2i export RISH_APPLICATION_ID="com.termux"' "$BIN/rish"

chmod +x "$BIN/rish"
chmod -w "$BIN/rish_shizuku.dex"

echo -e "${GRN}✅ Shizuku setup complete${R}"
echo "Test: rish -c whoami"