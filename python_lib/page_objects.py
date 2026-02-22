"""
Page Object Model for OrangeHRM Login Page
"""
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.remote.webdriver import WebDriver
from selenium.common.exceptions import TimeoutException, NoSuchElementException
from typing import Optional
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class LoginPageLocators:
    """Locators for Login Page elements"""
    
    # Login form elements
    USERNAME_FIELD = (By.NAME, "username")
    PASSWORD_FIELD = (By.NAME, "password")
    LOGIN_BUTTON = (By.XPATH, "//button[@type='submit']")
    
    # Error messages
    ERROR_MESSAGE = (By.XPATH, "//div[@class='oxd-alert-content oxd-alert-content--error']")
    INVALID_CREDENTIALS = (By.XPATH, "//p[contains(text(), 'Invalid credentials')]")
    
    # Loading indicator
    LOADING_SPINNER = (By.XPATH, "//div[@class='oxd-loading-spinner']")


class DashboardPageLocators:
    """Locators for Dashboard Page elements"""
    
    # Dashboard elements
    DASHBOARD_HEADER = (By.XPATH, "//h6[text()='Dashboard']")
    USER_DROPDOWN = (By.XPATH, "//span[@class='oxd-userdropdown-tab']")
    PROFILE_PICTURE = (By.XPATH, "//img[@class='oxd-userdropdown-img']")
    MAIN_MENU = (By.XPATH, "//nav[@class='oxd-navbar-nav']")
    
    # Quick access widgets
    TIME_AT_WORK = (By.XPATH, "//p[text()='Time at Work']")
    MY_ACTIONS = (By.XPATH, "//p[text()='My Actions']")
    QUICK_LAUNCH = (By.XPATH, "//p[text()='Quick Launch']")


class LoginPage:
    """Page Object for OrangeHRM Login Page"""
    
    def __init__(self, driver: WebDriver, timeout: int = 20):
        self.driver = driver
        self.wait = WebDriverWait(driver, timeout)
        self.timeout = timeout
        
    def navigate_to_login_page(self, base_url: str) -> bool:
        """
        Navigate to the login page
        
        Args:
            base_url (str): Base URL of the application
            
        Returns:
            bool: True if navigation successful, False otherwise
        """
        try:
            logger.info(f"Navigating to login page: {base_url}")
            self.driver.get(base_url)
            
            # Wait for username field to be present
            self.wait.until(EC.presence_of_element_located(LoginPageLocators.USERNAME_FIELD))
            logger.info("Successfully navigated to login page")
            return True
            
        except TimeoutException:
            logger.error("Failed to load login page - username field not found")
            return False
        except Exception as e:
            logger.error(f"Unexpected error navigating to login page: {str(e)}")
            return False
    
    def enter_username(self, username: str) -> bool:
        """
        Enter username in the username field
        
        Args:
            username (str): Username to enter
            
        Returns:
            bool: True if successful, False otherwise
        """
        try:
            username_field = self.wait.until(
                EC.element_to_be_clickable(LoginPageLocators.USERNAME_FIELD)
            )
            username_field.clear()
            username_field.send_keys(username)
            logger.info(f"Successfully entered username: {username}")
            return True
            
        except TimeoutException:
            logger.error("Username field not found or not clickable")
            return False
        except Exception as e:
            logger.error(f"Error entering username: {str(e)}")
            return False
    
    def enter_password(self, password: str) -> bool:
        """
        Enter password in the password field
        
        Args:
            password (str): Password to enter
            
        Returns:
            bool: True if successful, False otherwise
        """
        try:
            password_field = self.wait.until(
                EC.element_to_be_clickable(LoginPageLocators.PASSWORD_FIELD)
            )
            password_field.clear()
            password_field.send_keys(password)
            logger.info("Successfully entered password")
            return True
            
        except TimeoutException:
            logger.error("Password field not found or not clickable")
            return False
        except Exception as e:
            logger.error(f"Error entering password: {str(e)}")
            return False
    
    def click_login_button(self) -> bool:
        """
        Click the login button
        
        Returns:
            bool: True if successful, False otherwise
        """
        try:
            login_button = self.wait.until(
                EC.element_to_be_clickable(LoginPageLocators.LOGIN_BUTTON)
            )
            login_button.click()
            logger.info("Successfully clicked login button")
            return True
            
        except TimeoutException:
            logger.error("Login button not found or not clickable")
            return False
        except Exception as e:
            logger.error(f"Error clicking login button: {str(e)}")
            return False
    
    def wait_for_loading_to_complete(self, timeout: int = 10) -> bool:
        """
        Wait for loading spinner to disappear
        
        Args:
            timeout (int): Maximum time to wait
            
        Returns:
            bool: True if loading completed, False if timeout
        """
        try:
            # Wait for loading spinner to appear and then disappear
            WebDriverWait(self.driver, timeout).until(
                EC.invisibility_of_element_located(LoginPageLocators.LOADING_SPINNER)
            )
            logger.info("Loading completed")
            return True
            
        except TimeoutException:
            logger.info("No loading spinner found or loading completed quickly")
            return True
        except Exception as e:
            logger.warning(f"Error waiting for loading: {str(e)}")
            return True
    
    def get_error_message(self) -> Optional[str]:
        """
        Get error message if login failed
        
        Returns:
            Optional[str]: Error message text or None if no error
        """
        try:
            error_element = self.driver.find_element(*LoginPageLocators.ERROR_MESSAGE)
            return error_element.text
        except NoSuchElementException:
            try:
                error_element = self.driver.find_element(*LoginPageLocators.INVALID_CREDENTIALS)
                return error_element.text
            except NoSuchElementException:
                return None
        except Exception as e:
            logger.error(f"Error getting error message: {str(e)}")
            return None
    
    def login(self, username: str, password: str) -> bool:
        """
        Complete login process
        
        Args:
            username (str): Username
            password (str): Password
            
        Returns:
            bool: True if login successful, False otherwise
        """
        logger.info(f"Attempting to login with username: {username}")
        
        # Enter credentials
        if not self.enter_username(username):
            return False
            
        if not self.enter_password(password):
            return False
        
        # Click login
        if not self.click_login_button():
            return False
        
        # Wait for loading to complete
        self.wait_for_loading_to_complete()
        
        # Check for error messages
        error_message = self.get_error_message()
        if error_message:
            logger.error(f"Login failed with error: {error_message}")
            return False
        
        logger.info("Login process completed successfully")
        return True


class DashboardPage:
    """Page Object for OrangeHRM Dashboard Page"""
    
    def __init__(self, driver: WebDriver, timeout: int = 20):
        self.driver = driver
        self.wait = WebDriverWait(driver, timeout)
        self.timeout = timeout
    
    def is_dashboard_displayed(self) -> bool:
        """
        Verify if dashboard is displayed
        
        Returns:
            bool: True if dashboard is displayed, False otherwise
        """
        try:
            # Check for dashboard header
            dashboard_header = self.wait.until(
                EC.presence_of_element_located(DashboardPageLocators.DASHBOARD_HEADER)
            )
            
            # Additional verification - check for user dropdown
            user_dropdown = self.wait.until(
                EC.presence_of_element_located(DashboardPageLocators.USER_DROPDOWN)
            )
            
            logger.info("Dashboard is displayed successfully")
            return dashboard_header.is_displayed() and user_dropdown.is_displayed()
            
        except TimeoutException:
            logger.error("Dashboard elements not found - dashboard not displayed")
            return False
        except Exception as e:
            logger.error(f"Error verifying dashboard display: {str(e)}")
            return False
    
    def get_dashboard_title(self) -> Optional[str]:
        """
        Get dashboard page title
        
        Returns:
            Optional[str]: Dashboard title or None if not found
        """
        try:
            dashboard_header = self.driver.find_element(*DashboardPageLocators.DASHBOARD_HEADER)
            return dashboard_header.text
        except NoSuchElementException:
            logger.error("Dashboard header not found")
            return None
        except Exception as e:
            logger.error(f"Error getting dashboard title: {str(e)}")
            return None
    
    def is_user_logged_in(self) -> bool:
        """
        Verify if user is logged in by checking user dropdown
        
        Returns:
            bool: True if user is logged in, False otherwise
        """
        try:
            user_dropdown = self.wait.until(
                EC.element_to_be_clickable(DashboardPageLocators.USER_DROPDOWN)
            )
            return user_dropdown.is_displayed()
            
        except TimeoutException:
            logger.error("User dropdown not found - user may not be logged in")
            return False
        except Exception as e:
            logger.error(f"Error verifying user login status: {str(e)}")
            return False
