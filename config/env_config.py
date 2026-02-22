import os
from pathlib import Path

class EnvConfig:
    """
    Environment configuration for OrangeHRM automation tests.
    """
    
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    
    # Base URL
    BASE_URL = "https://opensource-demo.orangehrmlive.com"
    
    # Test credentials
    VALID_USERNAME = "Admin"
    VALID_PASSWORD = "admin123"
    
    # Browser settings
    BROWSER = os.getenv('BROWSER', 'chrome')
    HEADLESS = os.getenv('HEADLESS', 'false').lower() == 'true'
    IMPLICIT_WAIT = int(os.getenv('IMPLICIT_WAIT', '10'))
    EXPLICIT_WAIT = int(os.getenv('EXPLICIT_WAIT', '20'))
    
    # Screenshot settings
    SCREENSHOT_DIR = Path(__file__).parent.parent / "results" / "screenshots"
    
    # Timeouts
    PAGE_LOAD_TIMEOUT = int(os.getenv('PAGE_LOAD_TIMEOUT', '30'))
    
    @classmethod
    def get_config_value(cls, key: str, default=None):
        """Get configuration value with optional default."""
        return getattr(cls, key, default)
    
    @classmethod
    def ensure_screenshot_dir(cls):
        """Ensure screenshot directory exists."""
        cls.SCREENSHOT_DIR.mkdir(parents=True, exist_ok=True)
        return str(cls.SCREENSHOT_DIR)
