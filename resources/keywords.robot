*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          locators.robot
Resource          variables.robot


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
    [Documentation]    Launches browser and opens base URL - morent, Also Long timeout to ensure manual login can be performed until login steps are implemented in the framework
    Open Browser    ${BASE_URL}
    Maximize Browser Window
    Wait Until Element Is Visible    ${SIGNIN_BUTTON}    ${SHORT_TIMEOUT}

Login As A Valid User
    [Arguments]    ${USERNAME}    ${PASSWORD}
    [Documentation]    Login with valid credentials to the application
    ...    Prerequisite: Application is launched
    Wait Until Element Is Visible    ${SIGNIN_BUTTON}    ${SHORT_TIMEOUT}
     Wait Until Keyword Succeeds    ${LONG_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    Click Button    ${SIGNIN_BUTTON}
    Input Text When Element Is Visible    ${LOGIN_EMAIL_INPUT}    ${USERNAME}
    Wait Until Element Is Visible    ${CONTINUE_BUTTON}
    Click Button    ${CONTINUE_BUTTON}
    Input Text When Element Is Visible    ${LOGIN_PASSWORD_INPUT}    ${PASSWORD}
    Wait Until Element Is Visible    ${CONTINUE_BUTTON}
    Click Button    ${CONTINUE_BUTTON}
    Wait Until Keyword Succeeds    ${LONG_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    Wait Until Element Is Visible    ${ACCOUNT_BUTTON}

#====================================
# PROFILE PAGE KEYWORDS
#====================================

Navigate To Profile Page
    [Documentation]    Navigates to profile page from Home Page by clicking on Account button in the header and then clicking on Manage account button from the user menu, Also validates profile image is visible in profile page to ensure profile page is loaded successfully
    Wait Until Keyword Succeeds    ${SHORT_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    Click Element    ${ACCOUNT_BUTTON}
    Click Element    ${MANAGE_ACCOUNT_BUTTON}
    Wait Until Element Is Visible    ${UPDATE_PROFILE_BUTTON}
    Click Element    ${UPDATE_PROFILE_BUTTON}
    Wait Until Element Is Visible    ${PROFILE_IMAGE}

Validate Update Profile
    [Documentation]    Validates Profile page elements are visible
    ...    Prerequisite: An image should already be uploaded to successfully validate visibility of remove profile image button
    Wait Until Element Is Visible    ${PROFILE_IMAGE}
    Wait Until Element Is Visible    ${FIRST_NAME_INPUT}
    Wait Until Element Is Visible    ${LAST_NAME_INPUT}
    Wait Until Element Is Visible    ${UPLOAD_PROFILE_IMAGE_BUTTON}
    Wait Until Element Is Visible    ${REMOVE_PROFILE_IMAGE_BUTTON}
    Wait Until Element Is Visible    ${UPDATE_PROFILE_CANCEL_BUTTON}
    Wait Until Element Is Visible    ${UPDATE_PROFILE_SAVE_BUTTON}

Update Profile Names
    [Arguments]    ${FIRST_NAME}    ${LAST_NAME}
    [Documentation]    Update Firstname and Lastname with valid values also check no error messages are displayed for the input fields and updated name is displayed in profile page after saving the changes
    Input Text When Element Is Visible    ${FIRST_NAME_INPUT}    ${FIRST_NAME}
    Input Text When Element Is Visible    ${LAST_NAME_INPUT}    ${LAST_NAME}
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
