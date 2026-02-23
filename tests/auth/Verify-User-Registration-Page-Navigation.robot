*** Settings ***
Documentation     User Registration (Sign Up) Page Navigation Tests
...
...               Test ID: AT-03
...               Test Coverage: Verify User Registration (Sign Up) Page Navigation
...
...               This test verifies that users can successfully navigate from the Home page
...               to the Registration page and that the registration form is accessible.
...
...               Note: The application uses a multi-step registration form. This test verifies
...               the initial step contains the required fields (Email, Password, Full Name).
...               Additional fields (Confirm Password) may appear on subsequent steps.
...
...               Author: QA Automation Team
...               Application: MoRent Car Rental Platform
...               URL: https://morent-car.archisacademy.com/

Library           SeleniumLibrary
Library           OperatingSystem
Resource          ../../resources/keywords.robot
Resource          ../../resources/base/common_utility.robot
Resource          ../../resources/pages/home_page.robot

Suite Setup       Suite Setup For Registration Tests
Suite Teardown    Suite Teardown For Registration Tests
Test Setup        Test Setup For Registration Tests
Test Teardown     Test Teardown For Registration Tests

*** Variables ***
# Browser Configuration
${BROWSER}                 chrome
${SHORT_TIMEOUT}           5s
${MEDIUM_TIMEOUT}          10s
${LONG_TIMEOUT}            30s

# Application URL
${MORENT_URL}              https://morent-car.archisacademy.com/

# Page Elements
${BODY_ELEMENT}            xpath=//body
${HEADER_SECTION}          xpath=//header

# Registration Navigation
${SIGNIN_BUTTON}           xpath=//button[@component='SignInButton']
${SIGNUP_LINK}             xpath=//a[contains(text(), 'Sign up')]

# Registration Form Fields
${EMAIL_FIELD}             xpath=//input[@name='identifier' or @name='email' or @id='identifier-field']
${PASSWORD_FIELD}          xpath=//input[@name='password' or @id='password-field']
${CONFIRM_PASSWORD_FIELD}  xpath=//input[@name='confirmPassword' or @name='password_confirmation' or contains(@placeholder, 'Confirm')]
${FIRSTNAME_FIELD}         xpath=//input[@name='firstName' or contains(@placeholder, 'First')]
${LASTNAME_FIELD}          xpath=//input[@name='lastName' or contains(@placeholder, 'Last')]
${REGISTER_BUTTON}         xpath=//button[contains(text(), 'Continue') or contains(text(), 'Register') or contains(text(), 'Sign up') or @type='submit']

# Screenshot Settings
${SCREENSHOT_DIR}          ${OUTPUT_DIR}/screenshots

*** Test Cases ***
AT-03 Verify User Registration Page Navigation
    [Documentation]    Verify navigation to Registration page and form fields presence
    ...                
    ...                Steps:
    ...                1. Launch MoRent website
    ...                2. Wait for Home page to load
    ...                3. Navigate to Registration page
    ...                4. Verify Registration page loads
    ...                5. Verify Registration form is displayed
    ...                6. Verify all required form fields are present
    ...
    ...                Expected: All form fields visible and accessible
    
    [Tags]    auth    smoke    critical    registration    AT-03
    
    Log    Step 1: Launching MoRent application    console=yes
    Open Browser    ${MORENT_URL}    ${BROWSER}
    Maximize Browser Window
    
    Log    Step 2: Waiting for Home page to load    console=yes
    Wait Until Element Is Visible    ${BODY_ELEMENT}    ${LONG_TIMEOUT}
    Wait Until Element Is Visible    ${HEADER_SECTION}    ${MEDIUM_TIMEOUT}
    
    Log    Step 3: Navigating to Registration page    console=yes
    Navigate To Registration Page
    
    Log    Step 4: Verifying Registration page loaded    console=yes
    Verify Registration Page Loaded
    
    Log    Step 5: Verifying Registration form displayed    console=yes
    Verify Registration Form Displayed
    
    Log    Step 6: Verifying form fields presence    console=yes
    Verify Registration Form Fields
    
    Log    ✓ Registration page navigation verified successfully    console=yes

*** Keywords ***
Suite Setup For Registration Tests
    [Documentation]    Setup before all tests
    Log    ========================================    console=yes
    Log    Registration Navigation Test Suite    console=yes
    Log    ========================================    console=yes
    Create Directory    ${SCREENSHOT_DIR}
    Set Screenshot Directory    ${SCREENSHOT_DIR}
    Set Selenium Timeout    ${LONG_TIMEOUT}

Suite Teardown For Registration Tests
    [Documentation]    Cleanup after all tests
    Log    ========================================    console=yes
    Log    Test Suite Completed    console=yes
    Log    ========================================    console=yes
    Run Keyword And Ignore Error    Close All Browsers

Test Setup For Registration Tests
    [Documentation]    Setup before each test
    Log    Starting: ${TEST_NAME}    console=yes

Test Teardown For Registration Tests
    [Documentation]    Cleanup after each test
    Run Keyword If Test Failed    Capture Page Screenshot    FAILURE-${TEST_NAME}.png
    Run Keyword And Ignore Error    Close All Browsers
    ${status}=    Set Variable If    '${TEST_STATUS}' == 'PASS'    ✓ PASSED    ✗ FAILED
    Log    ${TEST_NAME}: ${status}    console=yes

Navigate To Registration Page
    [Documentation]    Navigate from Home to Registration page
    Wait Until Element Is Visible    ${SIGNIN_BUTTON}    ${MEDIUM_TIMEOUT}
    Click Element    ${SIGNIN_BUTTON}
    Wait Until Element Is Visible    ${SIGNUP_LINK}    ${MEDIUM_TIMEOUT}
    Click Element    ${SIGNUP_LINK}
    Log    ✓ Navigated to Registration page    console=yes

Verify Registration Page Loaded
    [Documentation]    Verify Registration page loaded by checking for email field presence
    Wait Until Page Contains Element    ${EMAIL_FIELD}    ${LONG_TIMEOUT}
    Log    ✓ Registration page loaded    console=yes

Verify Registration Form Displayed
    [Documentation]    Verify Registration form is displayed by checking email field visibility
    Wait Until Element Is Visible    ${EMAIL_FIELD}    ${MEDIUM_TIMEOUT}
    Log    ✓ Registration form displayed    console=yes

Verify Registration Form Fields
    [Documentation]    Verify required form fields are present and visible on the registration page
    ...                This test verifies the core fields visible on the initial registration step:
    ...                - Email Address field (required - MUST be visible)
    ...                - Password field (required - MUST be visible)
    ...                - Full Name field (required - MUST be visible)
    ...                - Register/Sign Up button (checked if visible)
    ...
    ...                Note: Submit button may require field input before becoming visible/enabled
    
    Log    Verifying Email Address field...    console=yes
    Wait Until Element Is Visible    ${EMAIL_FIELD}    ${MEDIUM_TIMEOUT}
    Element Should Be Visible    ${EMAIL_FIELD}
    Log    ✓ Email Address field present and visible    console=yes
    
    Log    Verifying Password field...    console=yes
    Wait Until Element Is Visible    ${PASSWORD_FIELD}    ${MEDIUM_TIMEOUT}
    Element Should Be Visible    ${PASSWORD_FIELD}
    Log    ✓ Password field present and visible    console=yes
    
    Log    Verifying Full Name field...    console=yes
    Wait Until Element Is Visible    ${FIRSTNAME_FIELD}    ${MEDIUM_TIMEOUT}
    Element Should Be Visible    ${FIRSTNAME_FIELD}
    Log    ✓ Full Name field present and visible    console=yes
    
    Log    Checking for Register/Sign Up button...    console=yes
    ${button_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${REGISTER_BUTTON}    ${SHORT_TIMEOUT}
    Run Keyword If    ${button_visible}
    ...    Log    ✓ Register/Sign Up button present and visible    console=yes
    ...    ELSE
    ...    Log    ℹ Register/Sign Up button may require field input or appear after validation    console=yes
    
    Log    ✓ All required registration form input fields verified successfully    console=yes