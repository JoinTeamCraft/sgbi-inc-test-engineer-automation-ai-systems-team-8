*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          locators.robot
Resource          ../resources/locators.robot

*** Variables ***
${BASE_URL}           https://morent-car.archisacademy.com/
${BROWSER}            chrome
${SHORT_TIMEOUT}    5s
${MEDIUM_TIMEOUT}   10s
${LONG_TIMEOUT}     30s
${WAIT_RETRY_INTERVAL}   500ms


*** Keywords ***
# Add your common keywords here
Example Keyword
    [Documentation]    Placeholder for a keyword
    No Operation

Launch Application
    [Documentation]    Launches browser and opens base URL
    Open Browser    ${BASE_URL}
    Maximize Browser Window
    Wait Until Keyword Succeeds    ${LONG_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    Validate Element Visible    ${ACCOUNT_BUTTON}


#====================================
# PROFILE PAGE KEYWORDS
#====================================

Navigate To Profile Page
    [Documentation]    Navigates to profile page from Home Page
    Wait Until Keyword Succeeds    ${SHORT_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    Click Element    ${ACCOUNT_BUTTON}
    Click Element    ${MANAGE_ACCOUNT_BUTTON}
    Wait Until Element Is Visible    ${UPDATE_PROFILE_BUTTON}
    Click Element    ${UPDATE_PROFILE_BUTTON}

Validate Element Visible
    [Arguments]    ${LOCATOR}
    [Documentation]    Waits for element and validates visibility
    Wait Until Element Is Visible    ${LOCATOR}    ${SHORT_TIMEOUT}
    Element Should Be Visible    ${LOCATOR}

Validate Update Profile
    [Documentation]    Validates Profile page
    Validate Element Visible    ${PROFILE_IMAGE}
    Validate Element Visible    ${FIRST_NAME_INPUT}
    Validate Element Visible    ${LAST_NAME_INPUT}
    Validate Element Visible    ${UPDATE_PROFILE_CANCEL_BUTTON}
    Validate Element Visible    ${UPDATE_PROFILE_SAVE_BUTTON}
    Validate Element Visible    ${UPLOAD_PROFILE_IMAGE_BUTTON}

Update Profile Names
    [Arguments]    ${FIRST_NAME}    ${LAST_NAME}
    [Documentation]    Update Firstname and Lastname with valid values
    Wait Until Element Is Visible   ${FIRST_NAME_INPUT}    ${SHORT_TIMEOUT}
    Input Text    ${FIRST_NAME_INPUT}    ${FIRST_NAME}
    Input Text    ${LAST_NAME_INPUT}    ${LAST_NAME}
    Wait Until Element Is Enabled    ${UPDATE_PROFILE_SAVE_BUTTON}
    Click Element    ${UPDATE_PROFILE_SAVE_BUTTON}
    Element Should Not Be Visible    ${ERROR_FIRST_NAME}
    Element Should Not Be Visible    ${ERROR_LAST_NAME}
    Wait Until Element Is Visible    ${UPDATE_PROFILE_BUTTON}



Verify Updated User Name
    [Arguments]    ${FIRST_NAME}    ${LAST_NAME}
    [Documentation]    Verify updated firstname and lastname match expected values
    ${EXPECTED_NAME}=    Set Variable    ${FIRST_NAME} ${LAST_NAME}
    Wait Until Element Is Visible    ${USER_PREVIEW_NAME}    ${SHORT_TIMEOUT}
    ${ACTUAL_NAME}=    Get Text    ${USER_PREVIEW_NAME}
    Should Be Equal    ${ACTUAL_NAME}    ${EXPECTED_NAME}
