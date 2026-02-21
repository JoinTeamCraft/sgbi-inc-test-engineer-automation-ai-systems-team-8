import os

class EnvConfig:
    """
    Template for environment configuration.
    """
    
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    BASE_URL = "https://morent-car.archisacademy.com/"
    BROWSER = "chrome"
    SHORT_WAIT_TIME = 5
    MEDIUM_WAIT_TIME = 10
    LONG_WAIT_TIME = 20

    def get_config_value(self):
        """Placeholder for config retrieval."""
        pass
