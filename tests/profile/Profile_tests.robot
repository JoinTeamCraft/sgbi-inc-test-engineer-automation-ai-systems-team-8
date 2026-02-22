*** Settings ***
Resource          ../../resources/pages/profile_page.robot
Resource          ../../resources/base/common_utility.robot
Resource          ../../resources/pages/login_page.robot

Test Teardown    Close All Browsers

*** Test Cases ***
TC_Verify_User_Profile_Update_name
    [Documentation]    Verify Update profile modal and update Firstname and Lastname with valid values and verify the updated name in profile page. Also reset the name to original values after verification
    [Tags]    profile
    common_utility.Launch Application
    login_page.Login As A Valid User    ${USER_EMAIL}    ${USER_PASSWORD}
    profile_page.Navigate To Profile Page
    profile_page.Validate Update Profile
    ${ORGINAL_FIRST_NAME}    ${ORGINAL_LAST_NAME} =    profile_page.Get Existing Profile Names
    profile_page.Update Profile Names    ${FIRST_NAME}    ${LAST_NAME}
    profile_page.Verify Updated User Name    ${FIRST_NAME}    ${LAST_NAME}
    Wait And Click Element   ${UPDATE_PROFILE_BUTTON}
    profile_page.Update Profile Names    ${ORGINAL_FIRST_NAME}    ${ORGINAL_LAST_NAME}


TC_Verify_Update_Profile_Picture_Functionality
    [Documentation]    Verify Update profile picture functionality by uploading a new profile picture and verifying the profile picture is updated in profile page and also verify the profile picture change is reflected in header as well after updating the profile picture
    [Tags]    profile
    common_utility.Launch Application
    login_page.Login As A Valid User    ${USER_EMAIL}    ${USER_PASSWORD}
    ${HOME_PAGE_OLD_SRC} =    Get Element Attribute    ${PROFILE_IMAGE}    srcset
    profile_page.Navigate To Profile Page
    profile_page.Validate Update Profile
    ${OLD_SRC} =    Get Element Attribute    ${PROFILE_IMAGE}    srcset
    profile_page.Verify Upload Profile Picture    ${PROFILE_PICTURE_PATH}
    Capture Page Screenshot    profile_updated.png
    profile_page.Verify Profile Picture Change in header    ${PROFILE_IMAGE}    ${OLD_SRC}
    Navigate to Home Page
    Wait Until Keyword Succeeds    ${SHORT_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    profile_page.Verify Profile Picture Change in header    ${PROFILE_IMAGE}    ${HOME_PAGE_OLD_SRC}
    #Verifies profile picture change is reflected in header as well after updating the profile picture
    Wait Until Keyword Succeeds    ${SHORT_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    Click Element    ${ACCOUNT_BUTTON}
    Wait Until Keyword Succeeds    ${SHORT_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    profile_page.Verify Profile Picture Change in header    ${PROFILE_IMAGE}    ${HOME_PAGE_OLD_SRC}
    #Verifies profile picture change is reflected in user dropdown as well after updating the profile picture