"""
Test utilities for OrangeHRM automation tests
Provides helper functions for screenshots, reporting, and test data
"""
import os
import logging
from datetime import datetime
from pathlib import Path
from typing import Optional, Dict, Any
from selenium.webdriver.remote.webdriver import WebDriver
import json

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class TestUtils:
    """Utility class for test operations"""
    
    @staticmethod
    def generate_timestamp() -> str:
        """Generate timestamp string for file naming"""
        return datetime.now().strftime("%Y%m%d_%H%M%S")
    
    @staticmethod
    def take_screenshot_on_failure(driver: WebDriver, test_name: str, 
                                 screenshot_dir: str = None) -> Optional[str]:
        """
        Take screenshot when test fails
        
        Args:
            driver (WebDriver): WebDriver instance
            test_name (str): Name of the test
            screenshot_dir (str): Directory to save screenshots
            
        Returns:
            Optional[str]: Path to screenshot file or None if failed
        """
        if not driver:
            logger.error("No WebDriver instance provided for screenshot")
            return None
        
        try:
            if not screenshot_dir:
                screenshot_dir = Path(__file__).parent.parent / "results" / "screenshots"
            
            # Ensure directory exists
            Path(screenshot_dir).mkdir(parents=True, exist_ok=True)
            
            # Generate filename with timestamp
            timestamp = TestUtils.generate_timestamp()
            filename = f"FAILED_{test_name}_{timestamp}.png"
            filepath = Path(screenshot_dir) / filename
            
            # Take screenshot
            driver.save_screenshot(str(filepath))
            logger.info(f"Failure screenshot saved: {filepath}")
            return str(filepath)
            
        except Exception as e:
            logger.error(f"Failed to take failure screenshot: {str(e)}")
            return None
    
    @staticmethod
    def log_test_result(test_name: str, status: str, duration: float = None, 
                       error_message: str = None, screenshot_path: str = None):
        """
        Log test result with details
        
        Args:
            test_name (str): Name of the test
            status (str): Test status (PASS/FAIL)
            duration (float): Test duration in seconds
            error_message (str): Error message if test failed
            screenshot_path (str): Path to failure screenshot
        """
        log_message = f"TEST RESULT: {test_name} - {status}"
        
        if duration:
            log_message += f" (Duration: {duration:.2f}s)"
        
        if status == "FAIL" and error_message:
            log_message += f" - Error: {error_message}"
        
        if screenshot_path:
            log_message += f" - Screenshot: {screenshot_path}"
        
        if status == "PASS":
            logger.info(log_message)
        else:
            logger.error(log_message)
    
    @staticmethod
    def save_test_data(data: Dict[Any, Any], filepath: str):
        """
        Save test data to JSON file
        
        Args:
            data (Dict[Any, Any]): Data to save
            filepath (str): Path to save file
        """
        try:
            # Ensure directory exists
            Path(filepath).parent.mkdir(parents=True, exist_ok=True)
            
            with open(filepath, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=2, ensure_ascii=False, default=str)
            
            logger.info(f"Test data saved: {filepath}")
            
        except Exception as e:
            logger.error(f"Failed to save test data: {str(e)}")
    
    @staticmethod
    def load_test_data(filepath: str) -> Optional[Dict[Any, Any]]:
        """
        Load test data from JSON file
        
        Args:
            filepath (str): Path to data file
            
        Returns:
            Optional[Dict[Any, Any]]: Loaded data or None if failed
        """
        try:
            if not Path(filepath).exists():
                logger.warning(f"Test data file not found: {filepath}")
                return None
            
            with open(filepath, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            logger.info(f"Test data loaded: {filepath}")
            return data
            
        except Exception as e:
            logger.error(f"Failed to load test data: {str(e)}")
            return None
    
    @staticmethod
    def clean_old_screenshots(screenshot_dir: str, max_age_days: int = 7):
        """
        Clean old screenshots to save disk space
        
        Args:
            screenshot_dir (str): Screenshot directory
            max_age_days (int): Maximum age in days to keep screenshots
        """
        try:
            screenshot_path = Path(screenshot_dir)
            if not screenshot_path.exists():
                return
            
            current_time = datetime.now()
            deleted_count = 0
            
            for file_path in screenshot_path.glob("*.png"):
                file_age = current_time - datetime.fromtimestamp(file_path.stat().st_mtime)
                
                if file_age.days > max_age_days:
                    file_path.unlink()
                    deleted_count += 1
            
            if deleted_count > 0:
                logger.info(f"Cleaned {deleted_count} old screenshots from {screenshot_dir}")
                
        except Exception as e:
            logger.error(f"Failed to clean old screenshots: {str(e)}")
    
    @staticmethod
    def get_browser_logs(driver: WebDriver) -> list:
        """
        Get browser console logs
        
        Args:
            driver (WebDriver): WebDriver instance
            
        Returns:
            list: Browser console logs
        """
        try:
            logs = driver.get_log('browser')
            return logs
        except Exception as e:
            logger.warning(f"Could not get browser logs: {str(e)}")
            return []
    
    @staticmethod
    def wait_for_page_load(driver: WebDriver, timeout: int = 30) -> bool:
        """
        Wait for page to fully load
        
        Args:
            driver (WebDriver): WebDriver instance
            timeout (int): Timeout in seconds
            
        Returns:
            bool: True if page loaded, False if timeout
        """
        try:
            from selenium.webdriver.support.ui import WebDriverWait
            from selenium.webdriver.support import expected_conditions as EC
            
            # Wait for document ready state
            WebDriverWait(driver, timeout).until(
                lambda d: d.execute_script('return document.readyState') == 'complete'
            )
            
            logger.info("Page loaded successfully")
            return True
            
        except Exception as e:
            logger.error(f"Page load timeout: {str(e)}")
            return False


class TestDataGenerator:
    """Generator for test data"""
    
    @staticmethod
    def generate_random_string(length: int = 8) -> str:
        """Generate random string"""
        import random
        import string
        
        letters = string.ascii_lowercase
        return ''.join(random.choice(letters) for _ in range(length))
    
    @staticmethod
    def generate_random_email(domain: str = "test.com") -> str:
        """Generate random email"""
        username = TestDataGenerator.generate_random_string(10)
        return f"{username}@{domain}"
    
    @staticmethod
    def generate_invalid_credentials() -> list:
        """Generate list of invalid credential combinations"""
        return [
            {"username": "", "password": ""},
            {"username": "invalid", "password": "invalid"},
            {"username": "Admin", "password": "wrong_password"},
            {"username": "wrong_user", "password": "admin123"},
            {"username": "admin", "password": ""},
            {"username": "", "password": "admin123"}
        ]
