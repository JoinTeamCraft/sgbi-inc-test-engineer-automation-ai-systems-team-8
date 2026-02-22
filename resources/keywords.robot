*** Settings ***
<<<<<<< HEAD
Documentation     Reusable keywords for OrangeHRM automation tests
Library           SeleniumLibrary
Library           ../python_lib/page_objects.py
Library           ../python_lib/test_utils.py
Library           ../config/env_config.py
Resource          locators.robot

*** Variables ***
${BASE_URL}       https://opensource-demo.orangehrmlive.com
${VALID_USERNAME}    Admin
${VALID_PASSWORD}    admin123

*** Keywords ***
Setup Browser
    [Documentation]    Initialize browser for testing
    [Arguments]    ${browser}=chrome    ${headless}=false
    ${options}=    Evaluate    sys.modules['selenium.webdriver.chrome.options'].Options()    sys, selenium.webdriver.chrome.options
    Run Keyword If    '${headless}' == 'true'    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --window-size=1920,1080
    Call Method    ${options}    add_argument    --start-maximized
    Create Webdriver    Chrome    chrome_options=${options}
    Set Selenium Implicit Wait    10
    Set Selenium Timeout    20

Navigate To OrangeHRM Login Page
    [Documentation]    Navigate to the OrangeHRM login page
    Go To    ${BASE_URL}
    Wait Until Element Is Visible    ${USERNAME_FIELD}    timeout=20s
    Title Should Contain    OrangeHRM

Enter Login Credentials
    [Documentation]    Enter username and password
    [Arguments]    ${username}    ${password}
    Input Text    ${USERNAME_FIELD}    ${username}
    Input Password    ${PASSWORD_FIELD}    ${password}

Click Login Button
    [Documentation]    Click the login button
    Click Button    ${LOGIN_BUTTON}

Perform Login
    [Documentation]    Complete login process with credentials
    [Arguments]    ${username}=${VALID_USERNAME}    ${password}=${VALID_PASSWORD}
    Enter Login Credentials    ${username}    ${password}
    Click Login Button
    Wait For Loading To Complete

Wait For Loading To Complete
    [Documentation]    Wait for any loading indicators to disappear
    Wait Until Page Does Not Contain Element    ${LOADING_SPINNER}    timeout=10s

Verify Dashboard Is Displayed
    [Documentation]    Verify that dashboard page is loaded successfully
    Wait Until Element Is Visible    ${DASHBOARD_HEADER}    timeout=20s
    Element Should Be Visible    ${USER_DROPDOWN}
    Page Should Contain Element    ${MAIN_MENU}
    Element Text Should Be    ${DASHBOARD_HEADER}    Dashboard

Verify Login Error
    [Documentation]    Verify that login error message is displayed
    Wait Until Element Is Visible    ${ERROR_MESSAGE}    timeout=10s
    Element Should Be Visible    ${ERROR_MESSAGE}

Take Screenshot On Failure
    [Documentation]    Take screenshot when test fails
    [Arguments]    ${test_name}
    ${timestamp}=    Get Time    epoch
    ${screenshot_name}=    Set Variable    FAILED_${test_name}_${timestamp}.png
    ${screenshot_path}=    Set Variable    ${EXECDIR}/results/screenshots/${screenshot_name}
    Capture Page Screenshot    ${screenshot_path}
    Log    Screenshot saved: ${screenshot_path}
    [Return]    ${screenshot_path}

Login With Valid Credentials
    [Documentation]    Login with valid credentials and verify dashboard
    Navigate To OrangeHRM Login Page
    Perform Login    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Verify Dashboard Is Displayed

Login With Invalid Credentials
    [Documentation]    Attempt login with invalid credentials
    [Arguments]    ${username}    ${password}
    Navigate To OrangeHRM Login Page
    Perform Login    ${username}    ${password}
    Verify Login Error

Logout From Application
    [Documentation]    Logout from the application
    Wait Until Element Is Visible    ${USER_DROPDOWN}    timeout=10s
    Click Element    ${USER_DROPDOWN}
    Wait Until Element Is Visible    xpath=//a[text()='Logout']    timeout=10s
    Click Element    xpath=//a[text()='Logout']
    Wait Until Element Is Visible    ${USERNAME_FIELD}    timeout=20s

Cleanup Test Environment
    [Documentation]    Clean up test environment
    Close All Browsers
=======
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          locators.robot

*** Keywords ***
# Add your common keywords here
Example Keyword
    [Documentation]    Placeholder for a keyword
    No Operation
>>>>>>> origin/master
