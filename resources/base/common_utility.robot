*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          ../../resources/variables.robot
Library            DateTime
Library            Collections
*** Variables ***
${LAUNCH_IDENTIFIER}          xpath=//button[@aria-label="User Settings"]

*** Keywords ***
# Add your common keywords here
Example Keyword
    [Documentation]    Placeholder for a keyword
    No Operation

Input Text When Element Is Visible
    [Arguments]    ${LOCATOR}    ${INPUT}
    [Documentation]    Waits for element and validates visibility of the element located by the provided locator
    Wait Until Element Is Visible    ${LOCATOR}    ${SHORT_TIMEOUT}
    Element Should Be Enabled        ${LOCATOR}
    Input Text    ${LOCATOR}    ${INPUT}

Launch Application
    [Documentation]    Launches browser and opens base URL, also validates Sign in button is visible to ensure application is loaded successfully
    ...    Prerequisite: Base URL should be set in environment variable or variables file
    Open Browser    ${BASE_URL}
    Maximize Browser Window
    Wait Until Keyword Succeeds    ${SHORT_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    Wait Until Element Is Visible    ${LAUNCH_IDENTIFIER}    ${SHORT_TIMEOUT}

Navigate to Home Page
    [Documentation]    Navigates to Home page by clicking on the application logo in the header and validates home page is loaded successfully by validating visibility of Account button in the header
    Go To    ${BASE_URL}
    Wait Until Keyword Succeeds    ${SHORT_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    Wait Until Element Is Visible    ${LAUNCH_IDENTIFIER}    ${SHORT_TIMEOUT}

Wait And Click Element
    [Arguments]    ${LOCATOR}
    [Documentation]    Waits for element to be visible and enabled and then clicks on the element located by the provided locator
    Wait Until Element Is Visible    ${LOCATOR}    ${SHORT_TIMEOUT}
    Wait Until Element Is Enabled    ${LOCATOR}    ${SHORT_TIMEOUT}
    Click Element    ${LOCATOR}

Capture Screenshot With Name
    [Arguments]    ${name}
    ${timestamp}=    Get Time    epoch
    Capture Page Screenshot    ${name}_${timestamp}.png

Get Random Pickup And Return Dates
    [Arguments]    ${pickup_min}=0    ${pickup_max}=10    ${return_min}=1    ${return_max}=10
    [Documentation]    Generates random pickup and return dates based on the provided minimum and maximum offsets in days from the current date. The pickup date is generated first, and the return date is generated based on the pickup date to ensure it is always after the pickup date.Example: Pickup 2–5 days from today, Return 1–7 days after pickup
    ${pickup_offset}=    Evaluate    random.randint(${pickup_min}, ${pickup_max})    modules=random
    ${today}=    Get Current Date
    ${pickup_raw}=      Add Time To Date    ${today}    ${pickup_offset} days

    ${return_offset}=    Evaluate    random.randint(${return_min}, ${return_max})    modules=random
    ${return_date}=      Add Time To Date    ${pickup_raw}    ${return_offset} days    result_format=%d-%m-%Y
    ${pickup_date}=       Convert Date    ${pickup_raw}    result_format=%d-%m-%Y
    RETURN    ${pickup_date}    ${return_date}

Select Dropdown Option By Name
    [Arguments]    ${dropdown_xpath}    ${option_name}
    # Click the dropdown to open it
    Click Element    ${dropdown_xpath}
    ${option_xpath}=    Set Variable    //div[contains(@class,'ant-select-item-option') and not(contains(@class,'ant-select-item-option-active')) and .//div[text()='${option_name}']]
    Wait Until Keyword Succeeds    ${SHORT_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    Click Element    ${option_xpath}
    Log    Selected option: ${option_name}