@echo off
echo ============================================
echo   Hotel Management System - Frontend Start
echo ============================================
echo.

cd /d "%~dp0hotely5d-web"

echo [1/3] Checking port 9001...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":9001.*LISTENING"') do (
    echo   Killing old process PID:%%a ...
    taskkill -PID %%a -F >nul 2>&1
)

echo [2/3] Checking dependencies...
if not exist "node_modules\" (
    echo   First run, installing dependencies...
    call npm install
) else (
    echo   Dependencies ready
)

echo [3/3] Starting dev server...
echo.
call npm run dev

pause
