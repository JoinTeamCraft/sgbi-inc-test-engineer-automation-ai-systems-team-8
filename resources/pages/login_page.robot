*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          ../../resources/base/common_utility.robot

*** Variables ***
#====================================
# LOGIN PAGE
#====================================
${LOGIN_EMAIL_INPUT}      id=identifier-field
${LOGIN_PASSWORD_INPUT}   id=password-field
${CONTINUE_BUTTON}        xpath=//form//button[@data-localization-key='formButtonPrimary']
#====================================

*** Keywords ***
# Add your common keywords here
Example Keyword
    [Documentation]    Placeholder for a keyword
    No Operation

Login As A Valid User
    [Arguments]    ${USERNAME}    ${PASSWORD}
    [Documentation]    Login with valid credentials to the application
    ...    Prerequisite: Application is launched and user credentials are set in environment variables or variables file
    Wait Until Element Is Visible    ${SIGNIN_BUTTON}    ${SHORT_TIMEOUT}
     Wait Until Keyword Succeeds    ${LONG_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    Click Button    ${SIGNIN_BUTTON}
    Input Text When Element Is Visible    ${LOGIN_EMAIL_INPUT}    ${USERNAME}
    Wait Until Element Is Visible    ${CONTINUE_BUTTON}
    Click Button    ${CONTINUE_BUTTON}
    Input Text When Element Is Visible    ${LOGIN_PASSWORD_INPUT}    ${PASSWORD}
    Wait Until Element Is Visible    ${CONTINUE_BUTTON}
    Click Button    ${CONTINUE_BUTTON}
    Wait Until Keyword Succeeds    ${LONG_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    Wait Until Element Is Visible    ${ACCOUNT_BUTTON}
