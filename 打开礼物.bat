@echo off
title Local Server Launcher

echo ========================================
echo       Local Server Launcher
echo ========================================
echo.

python --version >nul 2>&1
if %errorlevel% == 0 (
    echo [OK] Python detected
    echo Starting Python HTTP server...
    echo.
    echo Server address: http://localhost:8000
    echo Press Ctrl+C to stop server
    echo.
    start http://localhost:8000
    python -m http.server 8000
    goto :end
)

python3 --version >nul 2>&1
if %errorlevel% == 0 (
    echo [OK] Python3 detected
    echo Starting Python3 HTTP server...
    echo.
    echo Server address: http://localhost:8000
    echo Press Ctrl+C to stop server
    echo.
    start http://localhost:8000
    python3 -m http.server 8000
    goto :end
)

node --version >nul 2>&1
if %errorlevel% == 0 (
    echo [OK] Node.js detected
    echo Starting Node.js HTTP server...
    echo.
    echo Server address: http://localhost:8000
    echo Press Ctrl+C to stop server
    echo.
    start http://localhost:8000
    npx http-server -p 8000
    goto :end
)

php --version >nul 2>&1
if %errorlevel% == 0 (
    echo [OK] PHP detected
    echo Starting PHP built-in server...
    echo.
    echo Server address: http://localhost:8000
    echo Press Ctrl+C to stop server
    echo.
    start http://localhost:8000
    php -S localhost:8000
    goto :end
)

echo [ERROR] No development environment detected
echo.
echo Attempting to install Python automatically...
echo.

winget --version >nul 2>&1
if %errorlevel% == 0 (
    echo [OK] Windows Package Manager (winget) detected
    echo Installing Python using winget...
    echo.
    winget install Python.Python.3.12 --accept-package-agreements --accept-source-agreements
    if %errorlevel% == 0 (
        echo.
        echo [OK] Python installed successfully!
        echo.
        echo Please run this script again to start the server
        pause
        goto :end
    ) else (
        echo.
        echo [ERROR] winget installation failed
        goto :manual_install
    )
)

:manual_install
echo.
echo ========================================
echo      Manual Installation Options
echo ========================================
echo.
echo Automatic installation failed. Please choose:
echo.
echo [1] Download Python installer (Recommended)
echo [2] Open Python official website
echo [3] Exit
echo.
set /p choice="Please select (1-3): "

if "%choice%"=="1" goto :download_python
if "%choice%"=="2" goto :open_website
if "%choice%"=="3" goto :end
goto :manual_install

:download_python
echo.
echo Downloading Python installer...
echo.
echo Download link: https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe
echo.
echo Please click the link above to download and install
echo.
echo IMPORTANT: Check "Add Python to PATH" during installation
echo.
start https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe
pause
goto :end

:open_website
echo.
echo Opening Python official website...
start https://www.python.org/downloads/
pause
goto :end

:end
