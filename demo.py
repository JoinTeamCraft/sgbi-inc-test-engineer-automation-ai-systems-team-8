"""
Comprehensive demo script for OrangeHRM login functionality testing
Tests: Valid login, Invalid credentials, Cross-browser, Empty credentials
"""
import sys
import time
from pathlib import Path

# Add project root to path
project_root = Path(__file__).parent
sys.path.insert(0, str(project_root))

try:
    from python_lib.webdriver_manager import WebDriverManager
    from python_lib.page_objects import LoginPage, DashboardPage
    from python_lib.test_utils import TestUtils, TestDataGenerator
    from config.env_config import EnvConfig
    
    def test_valid_login(browser="chrome", headless=False):
        """Test Case 1: Valid Login"""
        print(f"🔐 Test Case 1: Valid Login ({browser})")
        print("-" * 40)
        
        driver_manager = WebDriverManager(browser=browser, headless=headless, implicit_wait=10)
        driver = None
        
        try:
            driver = driver_manager.create_driver()
            login_page = LoginPage(driver, 20)
            dashboard_page = DashboardPage(driver, 20)
            
            # Navigate to login page
            print("🌐 Navigating to OrangeHRM...")
            if not login_page.navigate_to_login_page(EnvConfig.BASE_URL):
                raise Exception("Failed to navigate to login page")
            
            print("✅ Login page loaded successfully")
            
            # Perform login with valid credentials
            print(f"🔑 Logging in with credentials: {EnvConfig.VALID_USERNAME}/***")
            if not login_page.login(EnvConfig.VALID_USERNAME, EnvConfig.VALID_PASSWORD):
                raise Exception("Login failed")
            
            print("✅ Login successful")
            
            # Verify dashboard
            print("📊 Verifying dashboard display...")
            if not dashboard_page.is_dashboard_displayed():
                raise Exception("Dashboard not displayed")
            
            # Get dashboard info
            title = dashboard_page.get_dashboard_title()
            print(f"📋 Dashboard title: '{title}'")
            print(f"👤 User logged in: {dashboard_page.is_user_logged_in()}")
            
            print("🎉 Valid Login Test - PASSED")
            return True
            
        except Exception as e:
            print(f"❌ Valid Login Test - FAILED: {str(e)}")
            if driver:
                TestUtils.take_screenshot_on_failure(driver, f"valid_login_{browser}", str(EnvConfig.SCREENSHOT_DIR))
            return False
            
        finally:
            if driver_manager:
                driver_manager.quit_driver()
            time.sleep(2)  # Brief pause between tests
    
    def test_invalid_credentials(browser="chrome", headless=False):
        """Test Case 2: Invalid Credentials"""
        print(f"🚫 Test Case 2: Invalid Credentials ({browser})")
        print("-" * 40)
        
        driver_manager = WebDriverManager(browser=browser, headless=headless, implicit_wait=10)
        driver = None
        test_results = []
        
        try:
            driver = driver_manager.create_driver()
            login_page = LoginPage(driver, 20)
            dashboard_page = DashboardPage(driver, 20)
            
            # Get invalid credentials test data
            invalid_creds = TestDataGenerator.generate_invalid_credentials()
            
            for i, creds in enumerate(invalid_creds, 1):
                username = creds["username"]
                password = creds["password"]
                
                print(f"\n📝 Test {i}: username='{username}', password='{'*' * len(password) if password else 'empty'}'")
                
                try:
                    # Navigate to login page
                    if not login_page.navigate_to_login_page(EnvConfig.BASE_URL):
                        print(f"❌ Failed to navigate to login page")
                        test_results.append(False)
                        continue
                    
                    # Attempt login with invalid credentials
                    login_result = login_page.login(username, password)
                    
                    if login_result:
                        # Check if dashboard is displayed (it shouldn't be)
                        dashboard_displayed = dashboard_page.is_dashboard_displayed()
                        if dashboard_displayed:
                            print(f"❌ Unexpected: Dashboard displayed with invalid credentials")
                            test_results.append(False)
                        else:
                            print(f"✅ Correct: Login appeared successful but no dashboard")
                            test_results.append(True)
                    else:
                        # Check for error message
                        error_message = login_page.get_error_message()
                        if error_message:
                            print(f"✅ Correct: Error message displayed - '{error_message}'")
                            test_results.append(True)
                        else:
                            print(f"⚠️  Login failed but no error message found")
                            test_results.append(True)  # Still valid behavior
                
                except Exception as e:
                    print(f"❌ Test {i} failed with exception: {str(e)}")
                    test_results.append(False)
                
                time.sleep(1)  # Brief pause between attempts
            
            passed_tests = sum(test_results)
            total_tests = len(test_results)
            
            if passed_tests == total_tests:
                print(f"\n🎉 Invalid Credentials Test - PASSED ({passed_tests}/{total_tests})")
                return True
            else:
                print(f"\n❌ Invalid Credentials Test - PARTIAL ({passed_tests}/{total_tests} passed)")
                return False
                
        except Exception as e:
            print(f"\n❌ Invalid Credentials Test - FAILED: {str(e)}")
            if driver:
                TestUtils.take_screenshot_on_failure(driver, f"invalid_creds_{browser}", str(EnvConfig.SCREENSHOT_DIR))
            return False
            
        finally:
            if driver_manager:
                driver_manager.quit_driver()
            time.sleep(2)
    
    def test_empty_credentials(browser="chrome", headless=False):
        """Test Case 3: Empty Credentials"""
        print(f"� Test Case 3: Empty Credentials ({browser})")
        print("-" * 40)
        
        driver_manager = WebDriverManager(browser=browser, headless=headless, implicit_wait=10)
        driver = None
        
        try:
            driver = driver_manager.create_driver()
            login_page = LoginPage(driver, 20)
            dashboard_page = DashboardPage(driver, 20)
            
            # Navigate to login page
            print("🌐 Navigating to OrangeHRM...")
            if not login_page.navigate_to_login_page(EnvConfig.BASE_URL):
                raise Exception("Failed to navigate to login page")
            
            print("✅ Login page loaded")
            
            # Test with completely empty credentials
            print("🔍 Testing with empty username and password...")
            login_result = login_page.login("", "")
            
            if login_result:
                # Check if dashboard is displayed (it shouldn't be)
                dashboard_displayed = dashboard_page.is_dashboard_displayed()
                if dashboard_displayed:
                    print("❌ Unexpected: Dashboard displayed with empty credentials")
                    return False
                else:
                    print("✅ Correct: No dashboard displayed")
            else:
                print("✅ Correct: Login failed as expected")
            
            # Check for error message
            error_message = login_page.get_error_message()
            if error_message:
                print(f"✅ Error message displayed: '{error_message}'")
            else:
                print("⚠️  No specific error message found")
            
            print("🎉 Empty Credentials Test - PASSED")
            return True
            
        except Exception as e:
            print(f"❌ Empty Credentials Test - FAILED: {str(e)}")
            if driver:
                TestUtils.take_screenshot_on_failure(driver, f"empty_creds_{browser}", str(EnvConfig.SCREENSHOT_DIR))
            return False
            
        finally:
            if driver_manager:
                driver_manager.quit_driver()
            time.sleep(2)
    
    def test_cross_browser():
        """Test Case 4: Cross Browser Testing"""
        print("🌐 Test Case 4: Cross Browser Testing")
        print("-" * 40)
        
        browsers = ["chrome", "firefox"]  # Add "edge" if needed
        results = {}
        
        for browser in browsers:
            print(f"\n🔧 Testing with {browser.upper()} browser...")
            
            try:
                # Test valid login with current browser
                result = test_valid_login(browser, headless=True)  # Use headless for speed
                results[browser] = result
                
                if result:
                    print(f"✅ {browser.upper()} - Login test passed")
                else:
                    print(f"❌ {browser.upper()} - Login test failed")
                    
            except Exception as e:
                print(f"❌ {browser.upper()} - Browser test failed: {str(e)}")
                results[browser] = False
            
            time.sleep(3)  # Pause between browser tests
        
        # Summary
        passed_browsers = sum(results.values())
        total_browsers = len(results)
        
        print(f"\n📊 Cross Browser Test Summary:")
        for browser, result in results.items():
            status = "✅ PASSED" if result else "❌ FAILED"
            print(f"   {browser.upper()}: {status}")
        
        if passed_browsers == total_browsers:
            print(f"\n🎉 Cross Browser Test - PASSED ({passed_browsers}/{total_browsers})")
            return True
        else:
            print(f"\n❌ Cross Browser Test - PARTIAL ({passed_browsers}/{total_browsers} passed)")
            return False
    
    def run_comprehensive_tests():
        """Run all test cases"""
        print("🚀 Starting OrangeHRM Comprehensive Login Tests...")
        print("=" * 60)
    def run_comprehensive_tests():
        """Run all test cases"""
        print("🚀 Starting OrangeHRM Comprehensive Login Tests...")
        print("=" * 60)
        
        # Ensure directories exist
        EnvConfig.ensure_screenshot_dir()
        TestUtils.clean_old_screenshots(str(EnvConfig.SCREENSHOT_DIR))
        
        test_results = {}
        start_time = time.time()
        
        # Test Case 1: Valid Login
        print("\n" + "=" * 60)
        test_results["valid_login"] = test_valid_login("chrome", headless=False)
        
        # Test Case 2: Invalid Credentials
        print("\n" + "=" * 60)
        test_results["invalid_credentials"] = test_invalid_credentials("chrome", headless=False)
        
        # Test Case 3: Empty Credentials
        print("\n" + "=" * 60)
        test_results["empty_credentials"] = test_empty_credentials("chrome", headless=False)
        
        # Test Case 4: Cross Browser Testing
        print("\n" + "=" * 60)
        test_results["cross_browser"] = test_cross_browser()
        
        # Final Summary
        total_duration = time.time() - start_time
        passed_tests = sum(test_results.values())
        total_tests = len(test_results)
        
        print("\n" + "=" * 60)
        print("📊 COMPREHENSIVE TEST RESULTS SUMMARY")
        print("=" * 60)
        
        for test_name, result in test_results.items():
            status = "✅ PASSED" if result else "❌ FAILED"
            formatted_name = test_name.replace("_", " ").title()
            print(f"{formatted_name:25} : {status}")
        
        print("-" * 60)
        print(f"Total Tests Run    : {total_tests}")
        print(f"Tests Passed       : {passed_tests}")
        print(f"Tests Failed       : {total_tests - passed_tests}")
        print(f"Success Rate       : {(passed_tests/total_tests)*100:.1f}%")
        print(f"Total Duration     : {total_duration:.2f} seconds")
        
        if passed_tests == total_tests:
            print("\n🎉 ALL TESTS PASSED! The automation framework is working perfectly.")
        elif passed_tests >= total_tests * 0.75:
            print(f"\n⚠️  MOSTLY SUCCESSFUL ({passed_tests}/{total_tests} passed)")
        else:
            print(f"\n❌ SEVERAL TESTS FAILED ({passed_tests}/{total_tests} passed)")
        
        print("\n� Check 'results/screenshots' folder for any failure screenshots")
        print("=" * 60)
        
        return passed_tests == total_tests
    
    def run_single_test_menu():
        """Interactive menu to run individual tests"""
        print("\n🎯 Select Test to Run:")
        print("1. Valid Login Test")
        print("2. Invalid Credentials Test")
        print("3. Empty Credentials Test")
        print("4. Cross Browser Test")
        print("5. Run All Tests")
        print("0. Exit")
        
        choice = input("\nEnter your choice (0-5): ").strip()
        
        if choice == "1":
            test_valid_login("chrome", headless=False)
        elif choice == "2":
            test_invalid_credentials("chrome", headless=False)
        elif choice == "3":
            test_empty_credentials("chrome", headless=False)
        elif choice == "4":
            test_cross_browser()
        elif choice == "5":
            run_comprehensive_tests()
        elif choice == "0":
            print("👋 Goodbye!")
            return False
        else:
            print("❌ Invalid choice. Please try again.")
        
        return True
    
    if __name__ == "__main__":
        print("=" * 60)
        print("� OrangeHRM Login Functionality Test Suite")
        print("=" * 60)
        print("\nThis demo includes:")
        print("✅ Valid Login Test")
        print("❌ Invalid Credentials Test (6 scenarios)")
        print("📭 Empty Credentials Test")
        print("🌐 Cross Browser Test (Chrome + Firefox)")
        
        print("\nChoose execution mode:")
        print("1. Run All Tests (Recommended)")
        print("2. Interactive Menu")
        
        mode = input("\nEnter your choice (1 or 2): ").strip()
        
        if mode == "1":
            success = run_comprehensive_tests()
            print(f"\n🏁 Test Suite {'COMPLETED SUCCESSFULLY' if success else 'COMPLETED WITH ISSUES'}")
        elif mode == "2":
            while run_single_test_menu():
                continue
        else:
            print("Running all tests by default...")
            success = run_comprehensive_tests()
        
        print("\n💡 Next Steps:")
        print("  - For full test suite: python run_tests.py --framework pytest")
        print("  - For Robot Framework: python run_tests.py --framework robot")
        print("  - For detailed reports: Check 'results' folder")

except ImportError as e:
    print(f"❌ Import Error: {e}")
    print("\n📋 To fix this, please install dependencies:")
    print("   pip install -r requirements.txt")
    print("\n💡 Or install individual packages:")
    print("   pip install selenium webdriver-manager pytest robotframework")
except Exception as e:
    print(f"❌ Unexpected Error: {e}")
    import traceback
    traceback.print_exc()
