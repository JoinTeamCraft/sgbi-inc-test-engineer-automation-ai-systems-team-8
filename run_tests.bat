@echo off
REM Windows batch script to run OrangeHRM automation tests

echo ========================================
echo OrangeHRM Automation Test Suite
echo ========================================

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Python is not installed or not in PATH
    pause
    exit /b 1
)

REM Install dependencies if requirements.txt exists
if exist requirements.txt (
    echo Installing dependencies...
    pip install -r requirements.txt
    if %errorlevel% neq 0 (
        echo Error: Failed to install dependencies
        pause
        exit /b 1
    )
)

REM Create results directory
if not exist results mkdir results
if not exist results\screenshots mkdir results\screenshots

echo.
echo Choose test framework:
echo 1. Pytest (Python)
echo 2. Robot Framework
echo 3. Both
set /p choice="Enter your choice (1-3): "

echo.
echo Choose browser:
echo 1. Chrome (default)
echo 2. Firefox
echo 3. Edge
set /p browser_choice="Enter your choice (1-3): "

set BROWSER=chrome
if "%browser_choice%"=="2" set BROWSER=firefox
if "%browser_choice%"=="3" set BROWSER=edge

echo.
set /p headless="Run in headless mode? (y/N): "
set HEADLESS_FLAG=
if /i "%headless%"=="y" set HEADLESS_FLAG=--headless

echo.
echo ========================================
echo Running tests with:
echo Framework: %choice%
echo Browser: %BROWSER%
echo Headless: %headless%
echo ========================================

if "%choice%"=="1" (
    echo Running Pytest tests...
    python run_tests.py --framework pytest --browser %BROWSER% %HEADLESS_FLAG%
) else if "%choice%"=="2" (
    echo Running Robot Framework tests...
    python run_tests.py --framework robot --browser %BROWSER%
) else if "%choice%"=="3" (
    echo Running Pytest tests...
    python run_tests.py --framework pytest --browser %BROWSER% %HEADLESS_FLAG%
    echo.
    echo Running Robot Framework tests...
    python run_tests.py --framework robot --browser %BROWSER%
) else (
    echo Invalid choice. Running default Pytest tests...
    python run_tests.py --framework pytest --browser %BROWSER% %HEADLESS_FLAG%
)

echo.
echo ========================================
echo Test execution completed!
echo Check results directory for reports
echo ========================================
pause
