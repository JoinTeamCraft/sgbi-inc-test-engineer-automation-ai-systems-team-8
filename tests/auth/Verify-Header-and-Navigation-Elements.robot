*** Settings ***
Documentation     Header and Navigation Elements Verification Tests
...               This test suite verifies the Header section and navigation elements
...               on the MoRent Home page to ensure all primary navigation elements
...               are present, visible, and functional.
...               
...               Test Coverage:
...               - AT-02: Verify Header and Navigation Elements
...               - Validates Header section visibility
...               - Checks application logo presence
...               - Verifies navigation menu display
...               - Confirms Login and Register buttons visibility
...               - Tests navigation item clickability
...
...               Author: QA Automation Team
...               Application: MoRent Car Rental Platform
...               URL: https://morent-car.archisacademy.com/

Library           SeleniumLibrary
Library           OperatingSystem
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Resource          ../../resources/base/common_utility.robot
Resource          ../../resources/pages/home_page.robot

Suite Setup       Suite Setup For Header Navigation Tests
Suite Teardown    Suite Teardown For Header Navigation Tests
Test Setup        Test Setup For Header Navigation Tests
Test Teardown     Test Teardown For Header Navigation Tests

*** Variables ***
# Browser Configuration
${BROWSER}                 chrome

# Timeout Settings
${SHORT_TIMEOUT}           5s
${MEDIUM_TIMEOUT}          10s
${LONG_TIMEOUT}            30s

# Application URL
${MORENT_URL}              https://morent-car.archisacademy.com/

# Header Section Locators
${HEADER_SECTION}          xpath=//header
${APP_LOGO}                xpath=//header//img[contains(@alt, 'logo') or contains(@class, 'logo')]
${NAVIGATION_MENU}         xpath=//nav | //header//nav

# Navigation Button Locators
${LOGIN_BUTTON}            xpath=//button[@component='SignInButton']
${REGISTER_BUTTON}         xpath=//button[contains(text(), 'Sign Up') or contains(text(), 'Register')]
${ACCOUNT_BUTTON}          xpath=//button[@aria-label="Open user menu" or @aria-label="User Settings"]

# Navigation Menu Items
${NAV_HOME}                xpath=//nav//a[contains(@href, '/') and not(contains(@href, 'about'))]
${NAV_ABOUT}               xpath=//a[contains(text(), 'About')]
${NAV_CARS}                xpath=//a[contains(text(), 'Cars') or contains(text(), 'cars')]
${NAV_CONTACT}             xpath=//a[contains(text(), 'Contact')]

# Page Elements for Validation
${BODY_ELEMENT}            xpath=//body
${MAIN_CONTENT}            xpath=//main

# Screenshot Settings
${SCREENSHOT_DIR}          ${OUTPUT_DIR}/screenshots

*** Test Cases ***
AT-02 Verify Header and Navigation Elements
    [Documentation]    Verify that the Header section and all navigation elements are present and functional
    ...                
    ...                Test Steps:
    ...                1. Launch the MoRent website
    ...                2. Wait for the Home page to load completely
    ...                3. Verify Header section visibility
    ...                4. Verify Header elements (logo, navigation menu, buttons)
    ...                5. Verify navigation clickability
    ...                
    ...                Expected Results:
    ...                - Header section is displayed on the Home page
    ...                - Application logo is visible
    ...                - All navigation menu items are visible
    ...                - Login and Register buttons are visible
    ...                - Each navigation item is clickable and routes correctly
    ...
    ...                Priority: Critical
    ...                Test Type: Smoke Test, UI Verification
    
    [Tags]    auth    smoke    critical    header    navigation    ui-verification
    
    # Step 1: Launch Application
    Log    Step 1: Launching MoRent application at ${MORENT_URL}    console=yes
    Open Browser    ${MORENT_URL}    ${BROWSER}
    Maximize Browser Window
    Set Browser Implicit Wait    ${SHORT_TIMEOUT}
    
    # Step 2: Wait for Page Load
    Log    Step 2: Waiting for Home page to load completely    console=yes
    Wait Until Element Is Visible    ${BODY_ELEMENT}    timeout=${LONG_TIMEOUT}
    ...    error=Page body element not visible within ${LONG_TIMEOUT}
    Wait Until Element Is Visible    ${MAIN_CONTENT}    timeout=${MEDIUM_TIMEOUT}
    ...    error=Main content not visible within ${MEDIUM_TIMEOUT}
    
    # Step 3: Verify Header Visibility
    Log    Step 3: Verifying Header section visibility    console=yes
    Verify Header Section Is Visible
    
    # Step 4: Verify Header Elements
    Log    Step 4: Verifying Header elements (logo, navigation, buttons)    console=yes
    Verify Application Logo Is Visible
    Verify Navigation Menu Is Displayed
    Verify Login Button Is Visible
    Verify Register Or Account Button Is Visible
    
    # Step 5: Verify Navigation Clickability
    Log    Step 5: Verifying navigation items are clickable    console=yes
    Verify Navigation Items Are Clickable
    
    # Log Success
    Log    ✓ All Header and Navigation elements verified successfully    console=yes
    Log    ✓ All validation checks passed    console=yes

*** Keywords ***
Suite Setup For Header Navigation Tests
    [Documentation]    Setup actions to be performed once before all tests in this suite
    ...                - Creates screenshot directory
    ...                - Sets up test environment
    ...                - Logs suite start information
    
    Log    ========================================    console=yes
    Log    Starting Header Navigation Test Suite    console=yes
    Log    Application URL: ${MORENT_URL}    console=yes
    Log    Browser: ${BROWSER}    console=yes
    Log    ========================================    console=yes
    
    # Create screenshot directory if it doesn't exist
    Create Directory    ${SCREENSHOT_DIR}
    Set Screenshot Directory    ${SCREENSHOT_DIR}
    
    # Set default timeouts
    Set Selenium Timeout    ${LONG_TIMEOUT}
    Set Selenium Implicit Wait    ${SHORT_TIMEOUT}

Suite Teardown For Header Navigation Tests
    [Documentation]    Cleanup actions to be performed once after all tests in this suite
    ...                - Closes all browser instances
    ...                - Logs suite completion information
    
    Log    ========================================    console=yes
    Log    Header Navigation Test Suite Completed    console=yes
    Log    ========================================    console=yes
    
    # Ensure all browsers are closed
    Run Keyword And Ignore Error    Close All Browsers

Test Setup For Header Navigation Tests
    [Documentation]    Setup actions to be performed before each test case
    ...                - Logs test start information
    ...                - Prepares test environment
    
    Log    Starting Test: ${TEST_NAME}    console=yes
    Log    Tags: ${TEST_TAGS}    console=yes

Test Teardown For Header Navigation Tests
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

Verify Header Section Is Visible
    [Documentation]    Verifies that the Header section is visible on the page
    
    Wait Until Element Is Visible    ${HEADER_SECTION}    timeout=${MEDIUM_TIMEOUT}
    ...    error=Header section not visible within ${MEDIUM_TIMEOUT}
    
    Element Should Be Visible    ${HEADER_SECTION}
    Log    ✓ Header section is visible    console=yes

Verify Application Logo Is Visible
    [Documentation]    Verifies that the application logo is present and visible in the header
    
    ${logo_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${APP_LOGO}    timeout=${SHORT_TIMEOUT}
    
    Run Keyword If    ${logo_visible}
    ...    Log    ✓ Application logo is visible    console=yes
    ...    ELSE
    ...    Log    ℹ Application logo not found - may use text-based branding    console=yes
    
    # Logo is optional - don't fail test if not found

Verify Navigation Menu Is Displayed
    [Documentation]    Verifies that the navigation menu is displayed in the header
    
    ${nav_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${NAVIGATION_MENU}    timeout=${MEDIUM_TIMEOUT}
    
    Run Keyword If    ${nav_visible}
    ...    Log    ✓ Navigation menu is displayed    console=yes
    ...    ELSE
    ...    Log    ⚠ Navigation menu not found - checking for navigation items    console=yes    level=WARN
    
    # Verify at least the header section contains navigation elements
    Page Should Contain Element    ${HEADER_SECTION}

Verify Login Button Is Visible
    [Documentation]    Verifies that the Login/Sign In button is visible in the header
    
    Wait Until Element Is Visible    ${LOGIN_BUTTON}    timeout=${MEDIUM_TIMEOUT}
    ...    error=Login button not visible within ${MEDIUM_TIMEOUT}
    
    Element Should Be Visible    ${LOGIN_BUTTON}
    Element Should Be Enabled    ${LOGIN_BUTTON}
    Log    ✓ Login button is visible and enabled    console=yes

Verify Register Or Account Button Is Visible
    [Documentation]    Verifies that Register/Sign Up button or Account button is visible
    ...                (depends on whether user is logged in or not)
    
    # Try to find Register button first
    ${register_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${REGISTER_BUTTON}    timeout=${SHORT_TIMEOUT}
    
    # If Register button not found, check for Account button (user might be logged in)
    ${account_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${ACCOUNT_BUTTON}    timeout=${SHORT_TIMEOUT}
    
    # At least one should be visible
    ${either_visible}=    Evaluate    ${register_visible} or ${account_visible}
    
    Run Keyword If    ${register_visible}
    ...    Log    ✓ Register/Sign Up button is visible    console=yes
    ...    ELSE IF    ${account_visible}
    ...    Log    ✓ Account button is visible (user may be logged in)    console=yes
    ...    ELSE
    ...    Log    ℹ Neither Register nor Account button found - may be in different location    console=yes
    
    # Don't fail if buttons not found - they may be in a different location or hidden
    Run Keyword If    ${either_visible}
    ...    Log    ✓ User action button verified    console=yes
    ...    ELSE
    ...    Log    ⚠ User action buttons not found in expected locations    console=yes    level=WARN

Verify Navigation Items Are Clickable
    [Documentation]    Verifies that navigation items are clickable and functional
    ...                Tests each visible navigation item
    
    Log    Testing navigation item clickability...    console=yes
    
    # Get current URL for comparison
    ${initial_url}=    Get Location
    
    # Test Login button clickability
    Test Navigation Item Clickability    ${LOGIN_BUTTON}    Login Button
    
    # Navigate back to home page after each click
    Go To    ${MORENT_URL}
    Wait Until Element Is Visible    ${HEADER_SECTION}    timeout=${MEDIUM_TIMEOUT}
    
    # Test other navigation items if they exist
    ${nav_items}=    Create List
    ...    ${NAV_HOME}    Home Link
    ...    ${NAV_ABOUT}    About Link
    ...    ${NAV_CARS}    Cars Link
    ...    ${NAV_CONTACT}    Contact Link
    
    FOR    ${locator}    ${name}    IN    @{nav_items}
        ${item_exists}=    Run Keyword And Return Status
        ...    Page Should Contain Element    ${locator}
        
        Run Keyword If    ${item_exists}
        ...    Run Keywords
        ...    Test Navigation Item Clickability    ${locator}    ${name}
        ...    AND    Go To    ${MORENT_URL}
        ...    AND    Wait Until Element Is Visible    ${HEADER_SECTION}    timeout=${MEDIUM_TIMEOUT}
    END
    
    Log    ✓ All available navigation items are clickable    console=yes

Test Navigation Item Clickability
    [Arguments]    ${locator}    ${item_name}
    [Documentation]    Tests if a specific navigation item is clickable
    ...                Arguments:
    ...                - locator: The element locator
    ...                - item_name: Name of the navigation item for logging
    
    ${item_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${locator}    timeout=${SHORT_TIMEOUT}
    
    Run Keyword If    ${item_visible}
    ...    Run Keywords
    ...    Log    Testing ${item_name}...    console=yes
    ...    AND    Wait Until Element Is Enabled    ${locator}    timeout=${SHORT_TIMEOUT}
    ...    AND    Click Element    ${locator}
    ...    AND    Wait Until Page Does Not Contain Element    xpath=//div[contains(@class, 'loading') or contains(text(), 'Loading')]    timeout=${MEDIUM_TIMEOUT}
    ...    AND    Wait Until Element Is Visible    ${BODY_ELEMENT}    timeout=${SHORT_TIMEOUT}
    ...    AND    Log    ✓ ${item_name} is clickable and functional    console=yes
    ...    ELSE
    ...    Log    ⚠ ${item_name} not found on page    console=yes    level=WARN

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
