@echo off
setlocal enabledelayedexpansion

echo =========================================
echo   BossAI Windows Setup
echo =========================================
echo.

:: ── Check Node.js ─────────────────────────
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Node.js not found. Install Node.js first.
    pause
    exit /b
)

:: ── Get API Key (optional) ────────────────
set /p API_KEY="Enter OpenRouter API Key (or press Enter to skip): "

echo.
echo Fetching free models...

powershell -NoProfile -Command ^
"$r = Invoke-RestMethod 'https://openrouter.ai/api/v1/models'; ^
$m = $r.data | Where-Object { $_.id -like '*:free' }; ^
$i=1; foreach ($x in $m) { Write-Host ($i.ToString()+') '+$x.id); $i++ }; ^
Write-Host ($i.ToString()+') Custom')" > "%TEMP%\models.txt"

type "%TEMP%\models.txt"
echo.

set /p MODEL_CHOICE="Choose model [default 1]: "
if "%MODEL_CHOICE%"=="" set MODEL_CHOICE=1

for /f "tokens=1,* delims=) " %%A in ('type "%TEMP%\models.txt" ^| findstr /b "%MODEL_CHOICE%)"') do (
    set MODEL_NAME=%%B
)

if "!MODEL_NAME!"=="Custom" (
    set /p MODEL_NAME="Enter custom model: "
)

if "!MODEL_NAME!"=="" set MODEL_NAME=qwen/qwen3.6-plus:free

echo.
echo Selected: !MODEL_NAME!
pause

:: ── Install OpenClaude ────────────────────
echo Installing OpenClaude...
call npm install -g @gitlawb/openclaude

:: ── Generate launcher ─────────────────────
echo Creating start.bat...

(
echo @echo off
echo set CLAUDE_CODE_USE_OPENAI=1
if not "%API_KEY%"=="" echo set OPENAI_API_KEY=%API_KEY%
echo set OPENAI_BASE_URL=https://openrouter.ai/api/v1
echo set OPENAI_MODEL=!MODEL_NAME!
echo echo Starting BossAI...
echo npx openclaude %%*
) > start.bat

echo.
echo =========================================
echo   Setup Complete!
echo =========================================
echo Run: start.bat
echo.

pause