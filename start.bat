@echo off
echo ============================================
echo   Hotel Management System - Backend Start
echo ============================================
echo.

cd /d "%~dp0"

echo [1/3] Checking database...
mysql -u root -proot123 -e "USE hotely5d" >nul 2>&1
if errorlevel 1 (
    echo   Database hotely5d not found, initializing...
    mysql -u root -proot123 -e "CREATE DATABASE IF NOT EXISTS hotely5d DEFAULT CHARSET utf8mb4" 2>nul
    mysql -u root -proot123 hotely5d < hotely5d.sql 2>nul
    if errorlevel 1 (
        echo   [WARN] Failed to init database. Please run hotely5d.sql manually.
    ) else (
        echo   Database initialized successfully.
    )
) else (
    echo   Database hotely5d already exists.
)

cd /d "%~dp0hotely5d"

echo [2/3] Checking port 8600...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8600.*LISTENING"') do (
    echo   Killing old process PID:%%a ...
    taskkill -PID %%a -F >nul 2>&1
)

echo [3/3] Starting backend...
echo.
call mvn spring-boot:run

pause
