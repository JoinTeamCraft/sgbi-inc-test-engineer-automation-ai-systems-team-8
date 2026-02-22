*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          ../../resources/variables.robot


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
