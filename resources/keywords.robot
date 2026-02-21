*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          locators.robot
Resource          ../resources/locators.robot

*** Keywords ***
# Add your common keywords here
Example Keyword
    [Documentation]    Placeholder for a keyword
    No Operation

Launch Application
    [Documentation]    Launches browser and opens base URL
    Open Browser    ${BASE_URL}
    Maximize Browser Window
    Sleep    30

Navigate To Profile Page
    [Documentation]    Navigates to profile page from Home Page
    Wait Until Keyword Succeeds    4s    500ms    Click Element    ${ACCOUNT_BUTTON}
    Click Element    ${MANAGE_ACCOUNT_BUTTON}
    Wait Until Element Is Visible    ${UPDATE_PROFILE_BUTTON}
    Click Element    ${UPDATE_PROFILE_BUTTON}

Validate Update Profile
    [Documentation]    Validates Profile page
    Wait Until Element Is Visible    ${PROFILE_IMAGE}
    Element Should Be Visible    ${PROFILE_IMAGE}
    Wait Until Element Is Visible    ${FIRST_NAME_INPUT}
    Element Should Be Visible    ${FIRST_NAME_INPUT}
    Wait Until Element Is Visible    ${LAST_NAME_INPUT}
    Element Should Be Visible    ${LAST_NAME_INPUT}
    Element Should Be Visible    ${UPDATE_PROFILE_CANCEL_BUTTON}
    Element Should Be Visible    ${UPDATE_PROFILE_SAVE_BUTTON}
    Element Should Be Visible    ${UPLOAD_PROFILE_IMAGE_BUTTON}

Update Profile Names
    [Arguments]    ${FIRST_NAME}    ${LAST_NAME}
    [Documentation]     Update Firstname and Lastname with valid values
    Wait Until Element Is Visible   ${FIRST_NAME_INPUT}    5s
    Clear Element Text    ${FIRST_NAME_INPUT}
    Input Text            ${FIRST_NAME_INPUT}    ${FIRST_NAME}
    Input Text            ${LAST_NAME_INPUT}    ${LAST_NAME}
    Wait Until Element Is Enabled    ${UPDATE_PROFILE_SAVE_BUTTON}
    Click Element    ${UPDATE_PROFILE_SAVE_BUTTON}
    Element Should Not Be Visible    ${ERROR_FIRST_NAME}
    Element Should Not Be Visible    ${ERROR_LAST_NAME}
    Wait Until Element Is Visible    ${UPDATE_PROFILE_BUTTON}



Verify Updated User Name
    [Arguments]    ${FIRST_NAME}    ${LAST_NAME}
    [Documentation]     Update Firstname and Lastname with valid values
    ${EXPECTED_NAME}=    Set Variable    ${FIRST_NAME} ${LAST_NAME}
    Wait Until Element Is Visible    ${USER_PREVIEW_NAME}
    ${ACTUAL_NAME}=    Get Text    ${USER_PREVIEW_NAME}
    Should Be Equal    ${ACTUAL_NAME}    ${EXPECTED_NAME}
