*** Settings ***
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Resource          ../../resources/pages/profile_page.robot
Resource          ../../resources/base/common_utility.robot
Resource          ../../resources/pages/login_page.robot

Test Teardown    Close All Browsers

*** Test Cases ***
TC_Verify_User_Profile_Update_name
    [Documentation]    Verify Update profile modal and update Firstname and Lastname with valid values and verify the updated name in profile page. Also reset the name to original values after verification

    common_utility.Launch Application
    login_page.Login As A Valid User    ${USER_EMAIL}    ${USER_PASSWORD}
    profile_page.Navigate To Profile Page
    profile_page.Validate Update Profile
    ${ORGINAL_FIRST_NAME}    ${ORGINAL_LAST_NAME} =    profile_page.Get Existing Profile Names
    profile_page.Update Profile Names    ${FIRST_NAME}    ${LAST_NAME}
    profile_page.Verify Updated User Name    ${FIRST_NAME}    ${LAST_NAME}
    Click Element    ${UPDATE_PROFILE_BUTTON}
    profile_page.Update Profile Names    ${ORGINAL_FIRST_NAME}    ${ORGINAL_LAST_NAME}

