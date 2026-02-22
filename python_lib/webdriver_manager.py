"""
WebDriver Manager for OrangeHRM automation tests
Handles browser setup, configuration, and cleanup
"""
from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.firefox.service import Service as FirefoxService
from selenium.webdriver.edge.service import Service as EdgeService
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.webdriver.firefox.options import Options as FirefoxOptions
from selenium.webdriver.edge.options import Options as EdgeOptions
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.firefox import GeckoDriverManager
from webdriver_manager.microsoft import EdgeChromiumDriverManager
from selenium.webdriver.remote.webdriver import WebDriver
from typing import Optional
import logging
from pathlib import Path
import os

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class WebDriverManager:
    """Manages WebDriver instances with proper configuration"""
    
    def __init__(self, browser: str = "chrome", headless: bool = False, 
                 implicit_wait: int = 10, page_load_timeout: int = 30):
        """
        Initialize WebDriver Manager
        
        Args:
            browser (str): Browser type (chrome, firefox, edge)
            headless (bool): Run browser in headless mode
            implicit_wait (int): Implicit wait timeout in seconds
            page_load_timeout (int): Page load timeout in seconds
        """
        self.browser = browser.lower()
        self.headless = headless
        self.implicit_wait = implicit_wait
        self.page_load_timeout = page_load_timeout
        self.driver: Optional[WebDriver] = None
        self.download_dir = str(Path(__file__).parent.parent / "results" / "downloads")
        
        # Ensure download directory exists
        Path(self.download_dir).mkdir(parents=True, exist_ok=True)
    
    def _get_chrome_options(self) -> ChromeOptions:
        """Get Chrome browser options"""
        options = ChromeOptions()
        
        if self.headless:
            options.add_argument("--headless")
            options.add_argument("--no-sandbox")
            options.add_argument("--disable-dev-shm-usage")
        
        # Performance and stability options
        options.add_argument("--disable-gpu")
        options.add_argument("--disable-extensions")
        options.add_argument("--disable-plugins")
        options.add_argument("--disable-images")
        options.add_argument("--disable-javascript")
        options.add_argument("--disable-web-security")
        options.add_argument("--allow-running-insecure-content")
        options.add_argument("--ignore-certificate-errors")
        options.add_argument("--ignore-ssl-errors")
        options.add_argument("--ignore-certificate-errors-spki-list")
        
        # Window size for consistent screenshots
        options.add_argument("--window-size=1920,1080")
        options.add_argument("--start-maximized")
        
        # Download preferences
        prefs = {
            "download.default_directory": self.download_dir,
            "download.prompt_for_download": False,
            "download.directory_upgrade": True,
            "safebrowsing.enabled": False,
            "safebrowsing.disable_download_protection": True
        }
        options.add_experimental_option("prefs", prefs)
        
        # Disable logging
        options.add_experimental_option("excludeSwitches", ["enable-logging"])
        options.add_experimental_option("useAutomationExtension", False)
        options.add_argument("--disable-blink-features=AutomationControlled")
        
        return options
    
    def _get_firefox_options(self) -> FirefoxOptions:
        """Get Firefox browser options"""
        options = FirefoxOptions()
        
        if self.headless:
            options.add_argument("--headless")
        
        # Set download preferences
        options.set_preference("browser.download.folderList", 2)
        options.set_preference("browser.download.dir", self.download_dir)
        options.set_preference("browser.download.useDownloadDir", True)
        options.set_preference("browser.helperApps.neverAsk.saveToDisk", 
                              "text/csv,application/pdf,application/vnd.ms-excel")
        
        return options
    
    def _get_edge_options(self) -> EdgeOptions:
        """Get Edge browser options"""
        options = EdgeOptions()
        
        if self.headless:
            options.add_argument("--headless")
        
        # Similar options to Chrome
        options.add_argument("--disable-gpu")
        options.add_argument("--disable-extensions")
        options.add_argument("--window-size=1920,1080")
        options.add_argument("--start-maximized")
        
        # Download preferences
        prefs = {
            "download.default_directory": self.download_dir,
            "download.prompt_for_download": False,
            "download.directory_upgrade": True
        }
        options.add_experimental_option("prefs", prefs)
        
        return options
    
    def create_driver(self) -> WebDriver:
        """
        Create and configure WebDriver instance
        
        Returns:
            WebDriver: Configured WebDriver instance
            
        Raises:
            ValueError: If unsupported browser is specified
            Exception: If driver creation fails
        """
        try:
            logger.info(f"Creating {self.browser} driver (headless: {self.headless})")
            
            if self.browser == "chrome":
                service = ChromeService(ChromeDriverManager().install())
                options = self._get_chrome_options()
                self.driver = webdriver.Chrome(service=service, options=options)
                
            elif self.browser == "firefox":
                service = FirefoxService(GeckoDriverManager().install())
                options = self._get_firefox_options()
                self.driver = webdriver.Firefox(service=service, options=options)
                
            elif self.browser == "edge":
                service = EdgeService(EdgeChromiumDriverManager().install())
                options = self._get_edge_options()
                self.driver = webdriver.Edge(service=service, options=options)
                
            else:
                raise ValueError(f"Unsupported browser: {self.browser}")
            
            # Configure timeouts
            self.driver.implicitly_wait(self.implicit_wait)
            self.driver.set_page_load_timeout(self.page_load_timeout)
            
            # Maximize window if not headless
            if not self.headless:
                self.driver.maximize_window()
            
            logger.info(f"Successfully created {self.browser} driver")
            return self.driver
            
        except Exception as e:
            logger.error(f"Failed to create {self.browser} driver: {str(e)}")
            raise
    
    def quit_driver(self):
        """Safely quit the WebDriver instance"""
        if self.driver:
            try:
                logger.info("Quitting WebDriver")
                self.driver.quit()
                self.driver = None
                logger.info("WebDriver quit successfully")
            except Exception as e:
                logger.error(f"Error quitting WebDriver: {str(e)}")
    
    def get_driver(self) -> Optional[WebDriver]:
        """Get current WebDriver instance"""
        return self.driver
    
    def restart_driver(self) -> WebDriver:
        """Restart the WebDriver instance"""
        logger.info("Restarting WebDriver")
        self.quit_driver()
        return self.create_driver()
    
    def take_screenshot(self, filepath: str) -> bool:
        """
        Take screenshot with current WebDriver
        
        Args:
            filepath (str): Path to save screenshot
            
        Returns:
            bool: True if screenshot taken successfully, False otherwise
        """
        if not self.driver:
            logger.error("No WebDriver instance available for screenshot")
            return False
        
        try:
            # Ensure directory exists
            Path(filepath).parent.mkdir(parents=True, exist_ok=True)
            
            self.driver.save_screenshot(filepath)
            logger.info(f"Screenshot saved: {filepath}")
            return True
            
        except Exception as e:
            logger.error(f"Failed to take screenshot: {str(e)}")
            return False
    
    def get_browser_info(self) -> dict:
        """
        Get browser information
        
        Returns:
            dict: Browser information
        """
        if not self.driver:
            return {"error": "No driver instance"}
        
        try:
            capabilities = self.driver.capabilities
            return {
                "browser_name": capabilities.get("browserName", "unknown"),
                "browser_version": capabilities.get("browserVersion", "unknown"),
                "platform": capabilities.get("platformName", "unknown"),
                "headless": self.headless
            }
        except Exception as e:
            logger.error(f"Error getting browser info: {str(e)}")
            return {"error": str(e)}
