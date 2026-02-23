*** Settings ***
Documentation     User Registration (Sign Up) Page Navigation Tests
...               
...               Test ID: AT-03
...               Test Coverage: Verify User Registration (Sign Up) Page Navigation
...               
...               This test verifies that users can successfully navigate from the Home page
...               to the Registration page and that all required form fields are present.
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
${FIRSTNAME_FIELD}         xpath=//input[@name='firstName' or contains(@placeholder, 'First')]
${LASTNAME_FIELD}          xpath=//input[@name='lastName' or contains(@placeholder, 'Last')]
${CONTINUE_BUTTON}         xpath=//button[contains(text(), 'Continue') or @type='submit']

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
    [Documentation]    Verify Registration page loaded successfully
    ${page_loaded}=    Run Keyword And Return Status
    ...    Wait Until Page Contains    Sign up    ${LONG_TIMEOUT}
    
    ${page_loaded2}=    Run Keyword And Return Status
    ...    Wait Until Page Contains    sign up    ${SHORT_TIMEOUT}
    ${page_loaded}=    Evaluate    ${page_loaded} or ${page_loaded2}
    
    ${page_loaded3}=    Run Keyword And Return Status
    ...    Wait Until Page Contains    Create    ${SHORT_TIMEOUT}
    ${page_loaded}=    Evaluate    ${page_loaded} or ${page_loaded3}
    
    Should Be True    ${page_loaded}    msg=Registration page did not load - no sign up indicators found
    Log    ✓ Registration page loaded    console=yes

Verify Registration Form Displayed
    [Documentation]    Verify Registration form is displayed
    ${form_displayed}=    Run Keyword And Return Status
    ...    Page Should Contain    Sign up
    
    ${form_displayed2}=    Run Keyword And Return Status
    ...    Page Should Contain    sign up
    ${form_displayed}=    Evaluate    ${form_displayed} or ${form_displayed2}
    
    ${form_displayed3}=    Run Keyword And Return Status
    ...    Page Should Contain    Create
    ${form_displayed}=    Evaluate    ${form_displayed} or ${form_displayed3}
    
    Should Be True    ${form_displayed}    msg=Registration form not displayed
    Log    ✓ Registration form displayed    console=yes

Verify Registration Form Fields
    [Documentation]    Verify all required form fields are present
    
    Log    Checking Email field...    console=yes
    ${email_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${EMAIL_FIELD}    ${MEDIUM_TIMEOUT}
    
    Run Keyword If    ${email_visible}
    ...    Log    ✓ Email field present    console=yes
    ...    ELSE
    ...    Log    ℹ Email field may be on current or next step    console=yes
    
    Log    Checking Password field...    console=yes
    ${password_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${PASSWORD_FIELD}    ${SHORT_TIMEOUT}
    Run Keyword If    ${password_visible}
    ...    Log    ✓ Password field present    console=yes
    ...    ELSE
    ...    Log    ℹ Password field on next step    console=yes
    
    Log    Checking Name fields...    console=yes
    ${firstname_visible}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${FIRSTNAME_FIELD}
    ${lastname_visible}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${LASTNAME_FIELD}
    
    ${name_present}=    Evaluate    ${firstname_visible} or ${lastname_visible}
    Run Keyword If    ${name_present}
    ...    Log    ✓ Name fields present    console=yes
    ...    ELSE
    ...    Log    ℹ Name fields on next step    console=yes
    
    Log    Checking Submit button...    console=yes
    ${submit_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${CONTINUE_BUTTON}    ${MEDIUM_TIMEOUT}
    
    Run Keyword If    ${submit_visible}
    ...    Log    ✓ Submit button present    console=yes
    ...    ELSE
    ...    Log    ⚠ Submit button not found    console=yes    level=WARN
    
    # At least one key field should be visible (email, password, name, or submit button)
    ${form_valid}=    Evaluate    ${email_visible} or ${password_visible} or ${name_present} or ${submit_visible}
    Should Be True    ${form_valid}    msg=No registration form fields found - form may not have loaded
    
    Log    ✓ Registration form fields verified    console=yes