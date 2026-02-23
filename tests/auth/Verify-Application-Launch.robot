*** Settings ***
Documentation     Authentication Tests for MoRent Application
...               This test suite verifies the application launch and authentication functionality
...               
...               Test Coverage:
...               - AT-01: Verify Application Launch
...               - Validates successful page load
...               - Checks for error pages (404, 500)
...               - Confirms home page container visibility
...
...               Author: QA Automation Team
...               Application: MoRent Car Rental Platform
...               URL: https://morent-car.archisacademy.com/

Library           SeleniumLibrary
Library           OperatingSystem
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Resource          ../../resources/base/common_utility.robot

Suite Setup       Suite Setup For Authentication Tests
Suite Teardown    Suite Teardown For Authentication Tests
Test Setup        Test Setup For Authentication Tests
Test Teardown     Test Teardown For Authentication Tests

*** Variables ***
# Browser Configuration
${BROWSER}                 chrome

# Timeout Settings
${SHORT_TIMEOUT}           5s
${MEDIUM_TIMEOUT}          10s
${LONG_TIMEOUT}            30s

# Application URL
${MORENT_URL}              https://morent-car.archisacademy.com/

# Page Element Locators
${HOME_CONTAINER}          xpath=//main
${BODY_ELEMENT}            xpath=//body
${PAGE_HEADER}             xpath=//header

# Error Messages to Check
@{ERROR_MESSAGES}          404    500    This site can't be reached    Page not found    Internal Server Error

# Screenshot Settings
${SCREENSHOT_DIR}          ${OUTPUT_DIR}/screenshots

*** Test Cases ***
AT-01 Verify Application Launch
    [Documentation]    Verify that the MoRent website loads successfully
    ...                
    ...                Test Steps:
    ...                1. Launch the MoRent website
    ...                2. Wait for the page to load completely
    ...                3. Verify no browser-level error pages (404, 500, blank page)
    ...                4. Verify Home page main container is present
    ...                5. Verify page readiness for further interactions
    ...                
    ...                Expected Results:
    ...                - MoRent website opens successfully
    ...                - Home page loads without errors
    ...                - Main Home page container is visible
    ...                - Application is ready for automated test execution
    ...
    ...                Priority: Critical
    ...                Test Type: Smoke Test
    
    [Tags]    auth    smoke    critical    application-launch
    
    # Step 1: Launch Application
    Log    Step 1: Launching MoRent application at ${MORENT_URL}    console=yes
    Open Browser    ${MORENT_URL}    ${BROWSER}
    Maximize Browser Window
    Set Browser Implicit Wait    ${SHORT_TIMEOUT}
    
    # Step 2: Wait for Page Load
    Log    Step 2: Waiting for page to load completely    console=yes
    Wait Until Element Is Visible    ${BODY_ELEMENT}    timeout=${LONG_TIMEOUT}
    ...    error=Page body element not visible within ${LONG_TIMEOUT}
    
    # Step 3: Verify No Error Pages
    Log    Step 3: Verifying no error pages are displayed    console=yes
    Verify No Error Pages Are Displayed
    
    # Step 4: Verify Home Page Container
    Log    Step 4: Verifying Home page main container is visible    console=yes
    Wait Until Element Is Visible    ${HOME_CONTAINER}    timeout=${LONG_TIMEOUT}
    ...    error=Home page main container not visible within ${LONG_TIMEOUT}
    Element Should Be Visible    ${HOME_CONTAINER}
    
    # Step 5: Verify Page Readiness
    Log    Step 5: Verifying page is ready for interactions    console=yes
    Wait Until Page Contains Element    ${PAGE_HEADER}    timeout=${MEDIUM_TIMEOUT}
    Page Should Not Contain    Loading...
    
    # Log Success
    Log    ✓ Application launched successfully and is ready for testing    console=yes
    Log    ✓ All validation checks passed    console=yes

*** Keywords ***
Suite Setup For Authentication Tests
    [Documentation]    Setup actions to be performed once before all tests in this suite
    ...                - Creates screenshot directory
    ...                - Sets up test environment
    ...                - Logs suite start information
    
    Log    ========================================    console=yes
    Log    Starting Authentication Test Suite    console=yes
    Log    Application URL: ${MORENT_URL}    console=yes
    Log    Browser: ${BROWSER}    console=yes
    Log    ========================================    console=yes
    
    # Create screenshot directory if it doesn't exist
    Create Directory    ${SCREENSHOT_DIR}
    Set Screenshot Directory    ${SCREENSHOT_DIR}
    
    # Set default timeouts
    Set Selenium Timeout    ${LONG_TIMEOUT}
    Set Selenium Implicit Wait    ${SHORT_TIMEOUT}

Suite Teardown For Authentication Tests
    [Documentation]    Cleanup actions to be performed once after all tests in this suite
    ...                - Closes all browser instances
    ...                - Logs suite completion information
    
    Log    ========================================    console=yes
    Log    Authentication Test Suite Completed    console=yes
    Log    ========================================    console=yes
    
    # Ensure all browsers are closed
    Run Keyword And Ignore Error    Close All Browsers

Test Setup For Authentication Tests
    [Documentation]    Setup actions to be performed before each test case
    ...                - Logs test start information
    ...                - Prepares test environment
    
    Log    Starting Test: ${TEST_NAME}    console=yes
    Log    Tags: ${TEST_TAGS}    console=yes

Test Teardown For Authentication Tests
    [Documentation]    Cleanup actions to be performed after each test case
    ...                - Captures screenshot on failure
    ...                - Closes browser
    ...                - Logs test completion
    
    # Capture screenshot if test failed
    Run Keyword If Test Failed    Capture Failure Screenshot
    
    # Close browser with error handling
    Run Keyword And Ignore Error    Close All Browsers
    
    # Log test completion
    ${status}=    Set Variable If    '${TEST_STATUS}' == 'PASS'    ✓ PASSED    ✗ FAILED
    Log    Test ${TEST_NAME}: ${status}    console=yes

Verify No Error Pages Are Displayed
    [Documentation]    Verifies that common error messages are not present on the page
    ...                Checks for: 404, 500, connection errors, and other common error messages
    
    FOR    ${error_message}    IN    @{ERROR_MESSAGES}
        ${error_present}=    Run Keyword And Return Status    Page Should Contain    ${error_message}
        Run Keyword If    ${error_present}
        ...    Fail    Error page detected: Page contains "${error_message}"
        Log    ✓ No "${error_message}" error found    console=yes
    END
    
    Log    ✓ All error page checks passed    console=yes

Capture Failure Screenshot
    [Documentation]    Captures a screenshot when a test fails
    ...                Screenshot filename includes test name and timestamp for easy identification
    
    ${timestamp}=    Get Time    epoch
    ${screenshot_name}=    Set Variable    FAILURE-${TEST_NAME}-${timestamp}
    
    # Capture screenshot with error handling
    ${screenshot_path}=    Run Keyword And Ignore Error    
    ...    Capture Page Screenshot    ${screenshot_name}.png
    
    Run Keyword If    '${screenshot_path}[0]' == 'PASS'
    ...    Log    Screenshot captured: ${screenshot_path}[1]    console=yes
    ...    ELSE
    ...    Log    Failed to capture screenshot    console=yes    level=WARN
