@echo off
echo ==========================================
echo OrangeHRM Automation Setup Script
echo ==========================================

echo Checking Python installation...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python from https://python.org
    pause
    exit /b 1
)

echo ✅ Python is installed

echo.
echo Installing Python dependencies...
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo ERROR: Failed to install dependencies
    echo Please check your internet connection and try again
    pause
    exit /b 1
)

echo ✅ Dependencies installed successfully

echo.
echo Creating results directories...
if not exist results mkdir results
if not exist results\screenshots mkdir results\screenshots
if not exist results\downloads mkdir results\downloads

echo ✅ Directories created

echo.
echo Testing setup with demo script...
python demo.py
if %errorlevel% neq 0 (
    echo WARNING: Demo script encountered issues
    echo This might be due to missing dependencies or network issues
)

echo.
echo ==========================================
echo Setup completed!
echo ==========================================
echo.
echo Quick start commands:
echo   .\run_tests.bat         - Interactive test runner
echo   python demo.py          - Quick demo
echo   python run_tests.py     - Command line runner
echo.
echo For more information, see README.md
echo ==========================================
pause
