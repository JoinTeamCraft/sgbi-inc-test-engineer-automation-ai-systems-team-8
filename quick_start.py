#!/usr/bin/env python3
"""
Quick Start Script for OrangeHRM Login Tests
Installs dependencies and runs all test scenarios
"""
import subprocess
import sys
import os
from pathlib import Path

def install_dependencies():
    """Install required Python packages"""
    print("📦 Installing dependencies...")
    
    try:
        # Install from requirements.txt
        subprocess.check_call([sys.executable, '-m', 'pip', 'install', '-r', 'requirements.txt'])
        print("✅ Dependencies installed successfully")
        return True
    except subprocess.CalledProcessError:
        print("⚠️ Failed to install from requirements.txt, trying individual packages...")
        
        # Fallback to individual packages
        packages = [
            'selenium==4.15.0',
            'webdriver-manager==4.0.1',
            'pytest==7.4.3',
            'pytest-html==4.1.1'
        ]
        
        try:
            for package in packages:
                subprocess.check_call([sys.executable, '-m', 'pip', 'install', package])
            print("✅ Core dependencies installed successfully")
            return True
        except subprocess.CalledProcessError as e:
            print(f"❌ Failed to install dependencies: {e}")
            return False

def check_python_version():
    """Check if Python version is compatible"""
    version = sys.version_info
    if version.major >= 3 and version.minor >= 7:
        print(f"✅ Python {version.major}.{version.minor}.{version.micro} is compatible")
        return True
    else:
        print(f"❌ Python {version.major}.{version.minor} is too old. Please use Python 3.7+")
        return False

def create_directories():
    """Create necessary directories"""
    dirs = ['results', 'results/screenshots', 'results/downloads']
    for dir_path in dirs:
        Path(dir_path).mkdir(parents=True, exist_ok=True)
    print("✅ Created necessary directories")

def run_quick_test():
    """Run a quick test to verify setup"""
    print("\n🧪 Running quick verification test...")
    
    try:
        # Import test to verify dependencies
        sys.path.insert(0, str(Path(__file__).parent))
        from python_lib.webdriver_manager import WebDriverManager
        from config.env_config import EnvConfig
        
        print("✅ All imports successful")
        
        # Quick browser test
        print("🔧 Testing browser setup...")
        driver_manager = WebDriverManager(browser="chrome", headless=True, implicit_wait=5)
        driver = driver_manager.create_driver()
        
        if driver:
            driver.get("https://www.google.com")
            print(f"✅ Browser test successful - Page title: {driver.title[:50]}...")
            driver_manager.quit_driver()
            return True
        else:
            print("❌ Failed to create browser instance")
            return False
            
    except Exception as e:
        print(f"❌ Quick test failed: {e}")
        return False

def main():
    """Main execution function"""
    print("🚀 OrangeHRM Test Suite Quick Start")
    print("=" * 50)
    
    # Check Python version
    if not check_python_version():
        return 1
    
    # Create directories
    create_directories()
    
    # Install dependencies
    if not install_dependencies():
        print("\n❌ Setup failed due to dependency installation issues")
        print("💡 Try running manually: pip install selenium webdriver-manager pytest")
        return 1
    
    # Run quick verification
    if not run_quick_test():
        print("\n⚠️ Setup completed but verification failed")
        print("💡 You can still try running: python demo.py")
    
    print("\n🎉 Setup completed successfully!")
    print("\n📋 Available commands:")
    print("   python demo.py                     # Comprehensive test demo")
    print("   python run_tests.py --framework pytest    # Full pytest suite")
    print("   .\\run_tests.bat                   # Interactive test runner")
    
    print(f"\n🎯 Target Application: https://opensource-demo.orangehrmlive.com")
    print(f"📧 Test Credentials: Admin / admin123")
    
    # Ask if user wants to run demo
    run_demo = input("\n❓ Would you like to run the comprehensive demo now? (y/N): ").lower().strip()
    
    if run_demo in ['y', 'yes']:
        print("\n🏃 Starting comprehensive demo...")
        try:
            import demo
            # This will run the demo
        except Exception as e:
            print(f"❌ Failed to run demo: {e}")
            print("💡 Try running manually: python demo.py")
    
    return 0

if __name__ == "__main__":
    try:
        exit_code = main()
        sys.exit(exit_code)
    except KeyboardInterrupt:
        print("\n\n⏹️ Setup cancelled by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Unexpected error: {e}")
        sys.exit(1)
