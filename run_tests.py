#!/usr/bin/env python3
"""
Main test runner for OrangeHRM automation tests
Supports both pytest and Robot Framework execution
"""
import argparse
import sys
import subprocess
from pathlib import Path
import os

def run_pytest(args):
    """Run pytest tests"""
    cmd = [
        sys.executable, "-m", "pytest",
        "tests/test_orangehrm_login.py",
        "-v",
        f"--html=results/pytest_report.html",
        "--self-contained-html"
    ]
    
    if args.browser:
        os.environ['BROWSER'] = args.browser
    
    if args.headless:
        os.environ['HEADLESS'] = 'true'
    
    if args.markers:
        cmd.extend(["-m", args.markers])
    
    print(f"Running command: {' '.join(cmd)}")
    return subprocess.run(cmd, cwd=Path(__file__).parent)

def run_robot(args):
    """Run Robot Framework tests"""
    cmd = [
        "robot",
        "--outputdir", "results",
        "--loglevel", "INFO"
    ]
    
    if args.include_tags:
        cmd.extend(["--include", args.include_tags])
    
    if args.exclude_tags:
        cmd.extend(["--exclude", args.exclude_tags])
    
    cmd.append("tests/auth/login_tests.robot")
    
    print(f"Running command: {' '.join(cmd)}")
    return subprocess.run(cmd, cwd=Path(__file__).parent)

def main():
    parser = argparse.ArgumentParser(description="OrangeHRM Test Runner")
    parser.add_argument(
        "--framework", 
        choices=["pytest", "robot"], 
        default="pytest",
        help="Test framework to use"
    )
    parser.add_argument(
        "--browser", 
        choices=["chrome", "firefox", "edge"], 
        default="chrome",
        help="Browser to use for testing"
    )
    parser.add_argument(
        "--headless", 
        action="store_true",
        help="Run browser in headless mode"
    )
    parser.add_argument(
        "--markers", 
        help="Pytest markers to run (e.g., 'smoke', 'auth')"
    )
    parser.add_argument(
        "--include-tags", 
        help="Robot Framework tags to include"
    )
    parser.add_argument(
        "--exclude-tags", 
        help="Robot Framework tags to exclude"
    )
    
    args = parser.parse_args()
    
    # Ensure results directory exists
    Path("results").mkdir(exist_ok=True)
    Path("results/screenshots").mkdir(exist_ok=True)
    
    if args.framework == "pytest":
        result = run_pytest(args)
    else:
        result = run_robot(args)
    
    return result.returncode

if __name__ == "__main__":
    sys.exit(main())
