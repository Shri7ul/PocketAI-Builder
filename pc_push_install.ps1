Write-Host ""
Write-Host "=== BossAI Safe Installer ===" -ForegroundColor Cyan
Write-Host ""

# ── Confirm helper ─────────────────────────
function Confirm($msg) {
    $res = Read-Host "$msg (y/n)"
    return ($res -eq "y")
}

# ── Check ADB ──────────────────────────────
Write-Host "[1/5] Checking ADB..." -ForegroundColor Magenta
$device = adb devices | Select-String "device$"

if (-not $device) {
    Write-Host "No device found. Enable USB Debugging." -ForegroundColor Red
    exit
}

$serial = ($device -split "\s+")[0]
Write-Host "Connected: $serial" -ForegroundColor Green

# ── Install Termux (optional) ───────────────
if (Confirm "Install Termux if missing?") {
    $termux = adb shell pm list packages com.termux
    if ($termux -notmatch "com.termux") {
        Write-Host "Installing Termux..."
        Invoke-WebRequest `
          -Uri "https://github.com/termux/termux-app/releases/latest/download/termux-app.apk" `
          -OutFile "$env:TEMP\termux.apk"
        adb install "$env:TEMP\termux.apk"
    }
}

# ── Skip dangerous permission grants ───────
Write-Host ""
Write-Host "[SAFE MODE] Skipping auto permission grants." -ForegroundColor Yellow

# ── Push scripts ───────────────────────────
if (Confirm "Push project scripts to phone?") {
    $projectDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

    adb push "$projectDir\termux_setup.sh" /sdcard/Download/
    adb push "$projectDir\scripts\mobile_tools.sh" /sdcard/Download/

    Write-Host "Scripts pushed." -ForegroundColor Green
}

# ── Manual bootstrap instruction ───────────
Write-Host ""
Write-Host "=== NEXT STEPS ===" -ForegroundColor Cyan
Write-Host "1. Open Termux on your phone"
Write-Host "2. Run:"
Write-Host "   bash ~/storage/shared/Download/termux_setup.sh"
Write-Host ""
Write-Host "Done." -ForegroundColor Green