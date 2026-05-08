@echo off
echo ============================================
echo   Hotel Management System - Backend Start
echo ============================================
echo.

cd /d "%~dp0hotely5d"

echo [1/2] Checking port 8600...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8600.*LISTENING"') do (
    echo   Killing old process PID:%%a ...
    taskkill -PID %%a -F >nul 2>&1
)

echo [2/2] Starting backend...
echo.
call mvn spring-boot:run

pause
