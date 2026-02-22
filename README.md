# OrangeHRM Automation Test Suite

## 🎯 Overview
Complete Selenium automation framework for OrangeHRM login functionality with production-ready code, following best practices for maintainability, scalability, and reliability.

## 🏗️ Architecture
- **Page Object Model (POM)**: Clean separation of page elements and business logic
- **Pytest Framework**: Modern Python testing with fixtures and parametrization  
- **Robot Framework**: Keyword-driven testing for business users
- **WebDriver Manager**: Automatic driver management for multiple browsers
- **Configuration Management**: Environment-specific settings
- **Screenshot on Failure**: Automatic failure documentation
- **Cross-browser Testing**: Chrome, Firefox, and Edge support

## 📁 Project Structure

```
├── config/
│   └── env_config.py          # Environment configuration
├── python_lib/
│   ├── page_objects.py        # Page Object Models
│   ├── webdriver_manager.py   # WebDriver management
│   ├── test_utils.py         # Test utilities
│   └── data_generator.py     # Test data generation
├── resources/
│   ├── keywords.robot        # Robot Framework keywords
│   └── locators.robot        # Element locators
├── tests/
│   ├── auth/
│   │   └── login_tests.robot # Robot Framework tests
│   └── test_orangehrm_login.py # Pytest tests
├── results/                  # Test reports and screenshots
├── requirements.txt          # Python dependencies
├── pytest.ini              # Pytest configuration
├── .env                     # Environment variables
├── run_tests.py            # Main test runner
└── run_tests.bat           # Windows batch script
```

## 🚀 Quick Start

### 1. Install Dependencies
```powershell
pip install -r requirements.txt
```

### 2. Run Tests (Interactive)
```powershell
.\run_tests.bat
```

### 3. Run Tests (Command Line)

#### Pytest Tests
```powershell
# Basic run
python run_tests.py --framework pytest

# Chrome headless
python run_tests.py --framework pytest --browser chrome --headless

# Firefox with specific markers
python run_tests.py --framework pytest --browser firefox --markers "smoke"

# Direct pytest
pytest tests/test_orangehrm_login.py -v --html=results/report.html
```

#### Robot Framework Tests
```powershell
# Basic run
python run_tests.py --framework robot

# With specific tags
robot --outputdir results --include auth tests/auth/login_tests.robot
```

## 🧪 Test Cases

### Pytest Tests (`test_orangehrm_login.py`)

1. **test_successful_login**
   - Navigate to OrangeHRM
   - Login with valid credentials  
   - Verify dashboard display

2. **test_login_with_invalid_credentials**
   - Test multiple invalid credential combinations
   - Verify error messages
   - Ensure dashboard is not displayed

3. **test_login_page_elements**
   - Verify all login page elements exist
   - Test form field interactions
   - Validate page title

4. **test_cross_browser_login**
   - Parametrized test for Chrome and Firefox
   - Ensures cross-browser compatibility

### Robot Framework Tests (`login_tests.robot`)

1. **Valid Login Test**
   - Positive authentication test
   - Tags: `auth`, `smoke`, `positive`

2. **Invalid Login Tests**
   - Empty credentials
   - Wrong username  
   - Wrong password
   - Tags: `auth`, `negative`

3. **Login Page Elements Test**
   - UI element verification
   - Tags: `auth`, `ui`

## ⚙️ Configuration

### Environment Variables (`.env`)
```bash
BROWSER=chrome              # chrome, firefox, edge
HEADLESS=false             # true for headless mode
IMPLICIT_WAIT=10           # Implicit wait timeout
EXPLICIT_WAIT=20           # Explicit wait timeout
PAGE_LOAD_TIMEOUT=30       # Page load timeout
```

### Browser Options
- **Chrome**: Default with optimized performance settings
- **Firefox**: Alternative browser testing
- **Edge**: Microsoft Edge support
- **Headless**: Background execution without GUI

## 📊 Features

### ✅ Production-Ready Features
- **WebDriverWait**: Explicit waits for robust element interactions
- **Try/Catch**: Comprehensive error handling with logging
- **Screenshot on Failure**: Automatic failure documentation  
- **Page Object Model**: Maintainable test structure
- **Logging**: Detailed execution logging
- **Cross-browser**: Multi-browser testing support
- **Configuration**: Environment-specific settings
- **Parallel Execution**: Ready for CI/CD integration

### 🎨 Advanced Capabilities  
- **Automatic Driver Management**: No manual driver downloads
- **Smart Waits**: Multiple wait strategies for stability
- **Test Data Generation**: Dynamic test data creation
- **Browser Log Capture**: Console error detection
- **Custom Reporting**: HTML and JSON reports
- **Cleanup Utilities**: Automatic screenshot cleanup

## 🔧 Test Execution Options

### Pytest Markers
```powershell
pytest -m "smoke"           # Smoke tests only
pytest -m "auth"            # Authentication tests  
pytest -m "positive"        # Positive test cases
pytest -m "not slow"        # Exclude slow tests
```

### Robot Framework Tags
```powershell
robot --include smoke       # Smoke tests
robot --exclude negative    # Exclude negative tests
robot --include "auth AND positive"  # Combined tags
```

## 📈 Reporting

### Generated Reports
- **Pytest**: `results/pytest_report.html` - Interactive HTML report
- **Robot Framework**: `results/report.html` - Detailed execution report  
- **Screenshots**: `results/screenshots/` - Failure screenshots
- **Logs**: `results/log.html` - Execution logs

### CI/CD Integration
```yaml
# Example for GitHub Actions
- name: Run Automation Tests
  run: |
    pip install -r requirements.txt
    python run_tests.py --framework pytest --browser chrome --headless
```

## 🛠️ Customization

### Adding New Tests
1. **Page Objects**: Add new pages to `python_lib/page_objects.py`
2. **Locators**: Update `resources/locators.robot`  
3. **Keywords**: Add reusable keywords to `resources/keywords.robot`
4. **Tests**: Create new test files following naming conventions

### Browser Configuration
Modify `python_lib/webdriver_manager.py` to add:
- New browser support
- Additional browser options
- Custom capabilities

### Environment Setup
Update `config/env_config.py` for:
- New test environments  
- Additional configuration parameters
- Environment-specific overrides

## 🔍 Troubleshooting

### Common Issues
1. **Driver Issues**: Automatic driver management resolves most issues
2. **Element Not Found**: Check locators and wait conditions  
3. **Timeout Errors**: Adjust timeout values in configuration
4. **Permission Errors**: Run as administrator if needed

### Debug Mode
```powershell
# Enable debug logging
pytest tests/ -v --log-cli-level=DEBUG

# Take screenshots manually
TestUtils.take_screenshot_on_failure(driver, "debug_test")
```

## 📝 Best Practices Implemented

1. **Page Object Pattern**: Separation of concerns
2. **Explicit Waits**: Reliable element interactions  
3. **Error Handling**: Comprehensive exception management
4. **Logging**: Detailed execution tracking
5. **Configuration**: Environment-independent tests
6. **Documentation**: Clear test documentation
7. **Maintainability**: Modular and extensible design

## 🤝 Contributing

1. Follow existing code patterns
2. Add tests for new functionality
3. Update documentation
4. Ensure cross-browser compatibility
5. Include error handling and logging

## 📄 License
This project is designed for educational and testing purposes.

---

**Target Application**: [OrangeHRM Demo](https://opensource-demo.orangehrmlive.com)
- **Username**: Admin  
- **Password**: admin123

**Author**: Senior QA Automation Engineer
**Framework**: Selenium + Python + Pytest + Robot Framework
