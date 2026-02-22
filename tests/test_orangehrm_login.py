"""
OrangeHRM Login Test Suite
Complete Selenium automation tests for login functionality
"""
import pytest
import logging
import time
from pathlib import Path
import sys
import os

# Add project root to path for imports
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))

from python_lib.webdriver_manager import WebDriverManager
from python_lib.page_objects import LoginPage, DashboardPage
from python_lib.test_utils import TestUtils, TestDataGenerator
from config.env_config import EnvConfig

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class TestOrangeHRMLogin:
    """Test class for OrangeHRM login functionality"""
    
    @pytest.fixture(scope="function")
    def setup_teardown(self):
        """Setup and teardown for each test"""
        logger.info("=== Test Setup ===")
        
        # Ensure screenshot directory exists
        EnvConfig.ensure_screenshot_dir()
        
        # Clean old screenshots
        TestUtils.clean_old_screenshots(str(EnvConfig.SCREENSHOT_DIR))
        
        # Create WebDriver
        self.driver_manager = WebDriverManager(
            browser=EnvConfig.BROWSER,
            headless=EnvConfig.HEADLESS,
            implicit_wait=EnvConfig.IMPLICIT_WAIT,
            page_load_timeout=EnvConfig.PAGE_LOAD_TIMEOUT
        )
        
        self.driver = self.driver_manager.create_driver()
        
        # Initialize page objects
        self.login_page = LoginPage(self.driver, EnvConfig.EXPLICIT_WAIT)
        self.dashboard_page = DashboardPage(self.driver, EnvConfig.EXPLICIT_WAIT)
        
        # Test data
        self.test_start_time = time.time()
        
        yield
        
        # Teardown
        logger.info("=== Test Teardown ===")
        test_duration = time.time() - self.test_start_time
        logger.info(f"Test duration: {test_duration:.2f} seconds")
        
        # Get browser logs
        browser_logs = TestUtils.get_browser_logs(self.driver)
        if browser_logs:
            logger.info(f"Browser logs captured: {len(browser_logs)} entries")
        
        # Quit driver
        self.driver_manager.quit_driver()
    
    def test_successful_login(self, setup_teardown):
        """
        Test successful login with valid credentials
        
        Test Steps:
        1. Navigate to OrangeHRM login page
        2. Enter valid username and password
        3. Click login button
        4. Verify dashboard is displayed
        """
        test_name = "test_successful_login"
        logger.info(f"Starting test: {test_name}")
        
        try:
            # Step 1: Navigate to login page
            assert self.login_page.navigate_to_login_page(EnvConfig.BASE_URL), \
                "Failed to navigate to login page"
            
            # Step 2: Perform login
            login_success = self.login_page.login(
                EnvConfig.VALID_USERNAME, 
                EnvConfig.VALID_PASSWORD
            )
            assert login_success, "Login process failed"
            
            # Step 3: Verify dashboard is displayed
            assert self.dashboard_page.is_dashboard_displayed(), \
                "Dashboard is not displayed after login"
            
            # Additional verification
            assert self.dashboard_page.is_user_logged_in(), \
                "User dropdown not found - user may not be logged in"
            
            # Get dashboard title
            dashboard_title = self.dashboard_page.get_dashboard_title()
            assert dashboard_title == "Dashboard", \
                f"Expected 'Dashboard' title, got '{dashboard_title}'"
            
            # Log successful test
            test_duration = time.time() - self.test_start_time
            TestUtils.log_test_result(test_name, "PASS", test_duration)
            
            logger.info(f"✅ {test_name} completed successfully")
            
        except Exception as e:
            # Take screenshot on failure
            screenshot_path = TestUtils.take_screenshot_on_failure(
                self.driver, test_name, str(EnvConfig.SCREENSHOT_DIR)
            )
            
            # Log failed test
            test_duration = time.time() - self.test_start_time
            TestUtils.log_test_result(
                test_name, "FAIL", test_duration, str(e), screenshot_path
            )
            
            logger.error(f"❌ {test_name} failed: {str(e)}")
            raise
    
    def test_login_with_invalid_credentials(self, setup_teardown):
        """
        Test login with invalid credentials
        
        Test Steps:
        1. Navigate to OrangeHRM login page
        2. Try login with various invalid credentials
        3. Verify error messages are displayed
        4. Verify dashboard is NOT displayed
        """
        test_name = "test_login_with_invalid_credentials"
        logger.info(f"Starting test: {test_name}")
        
        try:
            # Step 1: Navigate to login page
            assert self.login_page.navigate_to_login_page(EnvConfig.BASE_URL), \
                "Failed to navigate to login page"
            
            # Step 2: Test with invalid credentials
            invalid_credentials = TestDataGenerator.generate_invalid_credentials()
            
            for creds in invalid_credentials:
                username = creds["username"]
                password = creds["password"]
                
                logger.info(f"Testing invalid credentials: username='{username}', password='***'")
                
                # Attempt login
                login_result = self.login_page.login(username, password)
                
                # Login should fail or error message should be present
                if login_result:
                    # If login appears successful, verify dashboard is NOT displayed
                    assert not self.dashboard_page.is_dashboard_displayed(), \
                        f"Dashboard should not be displayed with invalid credentials: {username}/{password}"
                else:
                    # Check for error message
                    error_message = self.login_page.get_error_message()
                    assert error_message is not None, \
                        f"Expected error message for invalid credentials: {username}/{password}"
                    logger.info(f"Error message received: {error_message}")
                
                # Navigate back to login page for next test
                self.login_page.navigate_to_login_page(EnvConfig.BASE_URL)
                time.sleep(1)  # Small delay between attempts
            
            # Log successful test
            test_duration = time.time() - self.test_start_time
            TestUtils.log_test_result(test_name, "PASS", test_duration)
            
            logger.info(f"✅ {test_name} completed successfully")
            
        except Exception as e:
            # Take screenshot on failure
            screenshot_path = TestUtils.take_screenshot_on_failure(
                self.driver, test_name, str(EnvConfig.SCREENSHOT_DIR)
            )
            
            # Log failed test
            test_duration = time.time() - self.test_start_time
            TestUtils.log_test_result(
                test_name, "FAIL", test_duration, str(e), screenshot_path
            )
            
            logger.error(f"❌ {test_name} failed: {str(e)}")
            raise
    
    def test_login_page_elements(self, setup_teardown):
        """
        Test login page elements are present and functional
        
        Test Steps:
        1. Navigate to OrangeHRM login page
        2. Verify username field is present and functional
        3. Verify password field is present and functional
        4. Verify login button is present and clickable
        """
        test_name = "test_login_page_elements"
        logger.info(f"Starting test: {test_name}")
        
        try:
            # Step 1: Navigate to login page
            assert self.login_page.navigate_to_login_page(EnvConfig.BASE_URL), \
                "Failed to navigate to login page"
            
            # Step 2: Test username field
            assert self.login_page.enter_username("test_user"), \
                "Failed to enter text in username field"
            
            # Step 3: Test password field
            assert self.login_page.enter_password("test_password"), \
                "Failed to enter text in password field"
            
            # Step 4: Verify login button is clickable (but don't click)
            # We'll just verify the element exists and is enabled
            from selenium.webdriver.support.ui import WebDriverWait
            from selenium.webdriver.support import expected_conditions as EC
            from python_lib.page_objects import LoginPageLocators
            
            wait = WebDriverWait(self.driver, 10)
            login_button = wait.until(
                EC.element_to_be_clickable(LoginPageLocators.LOGIN_BUTTON)
            )
            
            assert login_button.is_enabled(), "Login button should be enabled"
            assert login_button.is_displayed(), "Login button should be visible"
            
            # Verify page title
            page_title = self.driver.title
            assert "OrangeHRM" in page_title, f"Expected 'OrangeHRM' in page title, got: {page_title}"
            
            # Log successful test
            test_duration = time.time() - self.test_start_time
            TestUtils.log_test_result(test_name, "PASS", test_duration)
            
            logger.info(f"✅ {test_name} completed successfully")
            
        except Exception as e:
            # Take screenshot on failure
            screenshot_path = TestUtils.take_screenshot_on_failure(
                self.driver, test_name, str(EnvConfig.SCREENSHOT_DIR)
            )
            
            # Log failed test
            test_duration = time.time() - self.test_start_time
            TestUtils.log_test_result(
                test_name, "FAIL", test_duration, str(e), screenshot_path
            )
            
            logger.error(f"❌ {test_name} failed: {str(e)}")
            raise
    
    @pytest.mark.parametrize("browser", ["chrome", "firefox"])
    def test_cross_browser_login(self, browser):
        """
        Test login across different browsers
        
        Args:
            browser (str): Browser to test with
        """
        test_name = f"test_cross_browser_login_{browser}"
        logger.info(f"Starting test: {test_name}")
        
        # Setup for specific browser
        driver_manager = WebDriverManager(
            browser=browser,
            headless=EnvConfig.HEADLESS,
            implicit_wait=EnvConfig.IMPLICIT_WAIT,
            page_load_timeout=EnvConfig.PAGE_LOAD_TIMEOUT
        )
        
        driver = None
        test_start_time = time.time()
        
        try:
            driver = driver_manager.create_driver()
            login_page = LoginPage(driver, EnvConfig.EXPLICIT_WAIT)
            dashboard_page = DashboardPage(driver, EnvConfig.EXPLICIT_WAIT)
            
            # Navigate to login page
            assert login_page.navigate_to_login_page(EnvConfig.BASE_URL), \
                f"Failed to navigate to login page in {browser}"
            
            # Perform login
            login_success = login_page.login(
                EnvConfig.VALID_USERNAME, 
                EnvConfig.VALID_PASSWORD
            )
            assert login_success, f"Login failed in {browser}"
            
            # Verify dashboard
            assert dashboard_page.is_dashboard_displayed(), \
                f"Dashboard not displayed in {browser}"
            
            # Log successful test
            test_duration = time.time() - test_start_time
            TestUtils.log_test_result(test_name, "PASS", test_duration)
            
            logger.info(f"✅ {test_name} completed successfully")
            
        except Exception as e:
            # Take screenshot on failure
            if driver:
                screenshot_path = TestUtils.take_screenshot_on_failure(
                    driver, test_name, str(EnvConfig.SCREENSHOT_DIR)
                )
            else:
                screenshot_path = None
            
            # Log failed test
            test_duration = time.time() - test_start_time
            TestUtils.log_test_result(
                test_name, "FAIL", test_duration, str(e), screenshot_path
            )
            
            logger.error(f"❌ {test_name} failed: {str(e)}")
            raise
        
        finally:
            # Cleanup
            if driver_manager:
                driver_manager.quit_driver()


if __name__ == "__main__":
    # Run tests when script is executed directly
    pytest.main([
        __file__,
        "-v",
        "--tb=short",
        f"--html={Path(__file__).parent.parent}/results/report.html",
        "--self-contained-html"
    ])
