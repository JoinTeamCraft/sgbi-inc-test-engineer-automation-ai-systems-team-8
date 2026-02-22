*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          ../../resources/variables.robot


*** Variables ***
#====================================
# HOME PAGE
#====================================
${SIGNIN_BUTTON}          xpath=//button[@component='SignInButton']

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
    Wait Until Element Is Visible    ${SIGNIN_BUTTON}    ${SHORT_TIMEOUT}
