*** Settings ***
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Teardown    Close All Browsers

*** Test Cases ***
TC_Verify_User_Profile_Updation_name
    [Documentation]    Verify Update profile modal and update Firstname and Lastname with valid values and verify the updated name in profile page. Also reset the name to original values after verification

    Launch Application
    Login As A Valid User    ${USER_EMAIL}    ${USER_PASSWORD}
    Navigate To Profile Page
    Validate Update Profile
    Update Profile Names    ${FIRST_NAME}    ${LAST_NAME}
    Verify Updated User Name    ${FIRST_NAME}    ${LAST_NAME}
    Click Element    ${UPDATE_PROFILE_BUTTON}
    Update Profile Names    ${RESET_FIRST_NAME}    ${RESET_LAST_NAME}
