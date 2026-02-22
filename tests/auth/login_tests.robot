*** Settings ***
Documentation     OrangeHRM Login Authentication Tests
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Setup        Setup Browser
Test Teardown     Cleanup Test Environment

*** Test Cases ***
Valid Login Test
    [Documentation]    Test successful login with valid credentials
    [Tags]    auth    smoke    positive
    Login With Valid Credentials

Invalid Login Test - Empty Credentials
    [Documentation]    Test login with empty username and password
    [Tags]    auth    negative
    [Setup]    Setup Browser
    Login With Invalid Credentials    ${EMPTY}    ${EMPTY}

Invalid Login Test - Wrong Username
    [Documentation]    Test login with wrong username
    [Tags]    auth    negative  
    [Setup]    Setup Browser
    Login With Invalid Credentials    wronguser    admin123

Invalid Login Test - Wrong Password
    [Documentation]    Test login with wrong password
    [Tags]    auth    negative
    [Setup]    Setup Browser  
    Login With Invalid Credentials    Admin    wrongpass

Login Page Elements Test
    [Documentation]    Verify login page elements are present
    [Tags]    auth    ui
    Navigate To OrangeHRM Login Page
    Element Should Be Visible    ${USERNAME_FIELD}
    Element Should Be Visible    ${PASSWORD_FIELD}
    Element Should Be Visible    ${LOGIN_BUTTON}
    Element Should Be Enabled    ${LOGIN_BUTTON}
