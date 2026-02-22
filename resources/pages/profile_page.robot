*** Settings ***
Documentation     Template for common locators
Library           SeleniumLibrary
Resource          ../../resources/base/common_utility.robot
Resource          ../../resources/pages/home_page.robot

*** Variables ***
#====================================
# USER ACCOUNT POP UP
#====================================
${USER_PREVIEW_NAME}      xpath=//div[@role='dialog']//span[contains(@class,'userPreviewMainIdentifierText')]
${MANAGE_ACCOUNT_BUTTON}  xpath=//div[@role='menu']//button[normalize-space()='Manage account']
${SIGN_OUT_BUTTON}        xpath=//div[@role='menu']//button[normalize-space()='Sign out']
#====================================
# ACCOUNT > PROFILE PAGE
#====================================
${UPDATE_PROFILE_BUTTON}  xpath=//button[@data-localization-key="userProfile.start.profileSection.primaryButton"]
${FIRST_NAME_INPUT}             id=firstName-field
${LAST_NAME_INPUT}              id=lastName-field
${UPLOAD_PROFILE_IMAGE_BUTTON}    xpath=//button[@data-localization-key="userProfile.profilePage.imageFormSubtitle"]
${REMOVE_PROFILE_IMAGE_BUTTON}    xpath=//button[@data-localization-key="userProfile.profilePage.imageFormDestructiveActionSubtitle"]
${PROFILE_IMAGE}          xpath=//img[contains(@class,'cl-avatarImage')]
${ERROR_FIRST_NAME}       id=error-firstName
${ERROR_LAST_NAME}        id=error-lastName
${UPDATE_PROFILE_SAVE_BUTTON}    xpath=//button[@data-localization-key="userProfile.formButtonPrimary__save"]
${UPDATE_PROFILE_CANCEL_BUTTON}    xpath=//button[@data-localization-key="userProfile.formButtonReset"]

*** Keywords ***
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

Get Existing Profile Names
    [Documentation]    Get existing profile firstname and lastname values from profile page and return the values
    ${current_first}=    Get Value    ${FIRST_NAME_INPUT}
    ${current_last}=     Get Value    ${LAST_NAME_INPUT}
    RETURN    ${current_first}    ${current_last}


