# MoRent Robot Framework Python Automation

Automated testing framework for the MoRent Car Rental Platform using Robot Framework with Python extensions and Selenium Library.

## 📋 Table of Contents
- [Project Overview](#project-overview)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [How to Run Tests](#how-to-run-tests)
- [Tools Used](#tools-used)
- [Test Coverage Summary](#test-coverage-summary)
- [Environment Variables](#environment-variables)
- [Test Data](#test-data)
- [Contributing](#contributing)

## 🎯 Project Overview

This project automates end-to-end testing for the MoRent Car Rental application, covering authentication, search, booking, and profile management functionalities.

**Application URL**: https://morent-car.archisacademy.com/

## 📁 Project Structure

```
morent-robot-python-automation/
│
├── tests/                          # Test suites organized by module
│   ├── auth/                       # Authentication tests
│   │   └── login_tests.robot
│   ├── search/                     # Search functionality tests
│   │   └── search_tests.robot
│   ├── booking/                    # Booking tests
│   │   └── booking_tests.robot
│   └── profile/                    # Profile management tests
│       └── Profile_tests.robot
│
├── resources/                      # Robot Framework resources
│   ├── keywords.robot              # Reusable keywords
│   ├── locators.robot              # Element locators
│   ├── variables.robot             # Global variables
│   ├── base/                       # Base utilities
│   │   └── common_utility.robot
│   ├── pages/                      # Page object models
│   │   ├── home_page.robot
│   │   ├── login_page.robot
│   │   ├── search_result_page.robot
│   │   ├── car_details_page.robot
│   │   └── profile_page.robot
│   └── Uploads/                    # Test data files
│       └── Valid_update_profile_picture.jpg
│
├── python_lib/                     # Custom Python libraries
│   ├── data_generator.py           # Test data generation utilities
│   ├── validators.py               # Validation utilities
│   └── date_utils.py               # Date/time utilities
│
├── config/                         # Configuration files
│   └── env_config.py               # Environment configuration
│
├── results/                        # Test execution results (gitignored)
│   └── .gitkeep
│
├── .gitignore                      # Git ignore rules
└── README.md                       # Project documentation
```

## 🔧 Prerequisites

Before setting up the project, ensure you have the following installed:

- **Python**: Version 3.8 or higher
- **pip**: Python package installer
- **Git**: Version control system
- **Chrome Browser**: For Selenium WebDriver (or your preferred browser)

## 🚀 Setup Instructions

### 1. Clone the Repository

```bash
git clone <repository-url>
cd morent-robot-python-automation
```

### 2. Create Virtual Environment (Recommended)

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On macOS/Linux:
source venv/bin/activate

# On Windows:
venv\Scripts\activate
```

### 3. Install Dependencies

```bash
pip install robotframework
pip install robotframework-seleniumlibrary
pip install selenium
```

### 4. Set Environment Variables

Create a `.env` file in the project root or set environment variables:

```bash
export MORENT_BASE_URL="https://morent-car.archisacademy.com/"
export MORENT_USER_EMAIL="your-test-email@example.com"
export MORENT_USER_PASSWORD="your-test-password"
```

### 5. Verify Installation

```bash
robot --version
```

## ▶️ How to Run Tests

### Run All Tests

```bash
robot --outputdir results tests/
```

### Run Specific Test Suite

```bash
# Run authentication tests
robot --outputdir results tests/auth/login_tests.robot

# Run profile tests
robot --outputdir results tests/profile/Profile_tests.robot

# Run search tests
robot --outputdir results tests/search/search_tests.robot

# Run booking tests
robot --outputdir results tests/booking/booking_tests.robot
```

### Run Tests by Tags

```bash
# Run smoke tests only
robot --outputdir results --include smoke tests/

# Run critical tests
robot --outputdir results --include critical tests/

# Run authentication tests
robot --outputdir results --include auth tests/
```

### Run Tests with Custom Browser

```bash
robot --outputdir results --variable BROWSER:firefox tests/
```

### Generate Reports

After test execution, the following reports are generated in the `results/` directory:

- **report.html** - High-level test execution report
- **log.html** - Detailed test execution log with screenshots
- **output.xml** - Machine-readable test output

Open reports in browser:
```bash
open results/report.html  # macOS
start results/report.html # Windows
xdg-open results/report.html # Linux
```

## 🛠️ Tools Used

| Tool | Version | Purpose |
|------|---------|---------|
| **Robot Framework** | Latest | Test automation framework |
| **SeleniumLibrary** | Latest | Web testing library for Robot Framework |
| **Python** | 3.8+ | Programming language for custom libraries |
| **Selenium WebDriver** | Latest | Browser automation |
| **Chrome/ChromeDriver** | Latest | Browser for test execution |

## 📊 Test Coverage Summary

### Authentication Tests (`tests/auth/`)

| Test ID | Test Name | Description | Priority | Tags |
|---------|-----------|-------------|----------|------|
| **AT-01** | Verify Application Launch | Validates successful application launch, page load, and readiness for testing | Critical | `auth`, `smoke`, `critical`, `application-launch` |

**Test Steps:**
1. Launch MoRent website
2. Wait for page to load completely
3. Verify no browser-level error pages (404, 500)
4. Verify Home page main container is present
5. Verify page readiness for interactions

**Expected Results:**
- MoRent website opens successfully
- Home page loads without errors
- Main Home page container is visible
- Application is ready for automated test execution

---

### Profile Tests (`tests/profile/`)

| Test ID | Test Name | Description | Tags |
|---------|-----------|-------------|------|
| **TC_001** | TC_Verify_User_Profile_Update_name | Verifies logged-in user can update First and Last name. Validates no error messages and updated name reflects on profile page and header dropdown. Resets name after verification. | `profile` |
| **TC_002** | TC_Verify_Update_Profile_Picture_Functionality | Verifies logged-in user can upload valid profile picture. Validates updated picture reflects on profile page and header avatar. | `profile` |

---

### Search Tests (`tests/search/`)

| Test ID | Test Name | Description | Tags |
|---------|-----------|-------------|------|
| TBD | Search functionality tests | To be implemented | `search` |

---

### Booking Tests (`tests/booking/`)

| Test ID | Test Name | Description | Tags |
|---------|-----------|-------------|------|
| TBD | Booking functionality tests | To be implemented | `booking` |

---

## 🔐 Environment Variables

| Variable | Description | Required | Example |
|----------|-------------|----------|---------|
| `MORENT_BASE_URL` | Base URL of the MoRent application | Yes | `https://morent-car.archisacademy.com/` |
| `MORENT_USER_EMAIL` | Test account email for authentication | Yes | `testuser@example.com` |
| `MORENT_USER_PASSWORD` | Test account password | Yes | `SecurePassword123` |

## 📦 Test Data

| File | Location | Used In | Description |
|------|----------|---------|-------------|
| `Valid_update_profile_picture.jpg` | `resources/Uploads/` | TC_002 | Valid image file for profile picture upload testing |

## 🤝 Contributing

### Commit Message Convention

All commits must follow this format:

```
[ticket-number] - <Meaningful Commit Message>
```

**Examples:**
- `[AT-01] - Implemented application launch verification test`
- `[AT-01] - Added .gitignore file with browser binaries exclusion`
- `[AT-01] - Updated README with project documentation`

### Pull Request Guidelines

When creating a pull request:

1. **Clear Description**: Explain what was implemented, why, and any decisions made
2. **Include Screenshots**: Add screenshots or screen recordings where applicable
3. **Test Coverage**: Document which test cases were implemented
4. **Edge Cases**: Mention any edge cases handled

### Git Workflow

1. **Commit Incrementally**: Make small, meaningful commits as you progress
2. **Do Not Push Everything at Once**: Break work into logical commits
3. **Update .gitignore**: Ensure browser binaries and large output folders are excluded

## 📝 Notes

- Browser binaries (Playwright/Selenium downloads) are excluded via `.gitignore`
- Test results and screenshots are excluded from version control
- All test data files in `resources/Uploads/` are tracked for test execution

## 📞 Support

For issues or questions, please contact the QA Automation Team.

---

**Author**: QA Automation Team  
**Application**: MoRent Car Rental Platform  
**Last Updated**: 2026-02-23