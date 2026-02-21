*** Settings ***
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Teardown    Close All Browsers

*** Variables ***
${FIRST_NAME}     Morent
${LAST_NAME}      TeamCraft
${RESET_FIRST_NAME}     test
${RESET_LAST_NAME}      morent


*** Test Cases ***
TC_Verify_User_Profile_Updation_name
    [Documentation]    Verify Update profile modal and update User names

    Launch Application
    #Manually perform the login here until login steps are implemented in the framework
    Navigate To Profile Page
    Validate Update Profile
    Update Profile Names    ${FIRST_NAME}    ${LAST_NAME}
    Verify Updated User Name    ${FIRST_NAME}    ${LAST_NAME}
    Click Element    ${UPDATE_PROFILE_BUTTON}
    Update Profile Names    ${RESET_FIRST_NAME}    ${RESET_LAST_NAME}