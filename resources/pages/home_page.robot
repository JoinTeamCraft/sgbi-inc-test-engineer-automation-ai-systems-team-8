*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          ../../resources/base/common_utility.robot

*** Variables ***

#====================================
# HOME PAGE
#====================================
${SIGNIN_BUTTON}          xpath=//button[@component='SignInButton']
${ACCOUNT_BUTTON}         xpath=//button[@aria-label="Open user menu"]
${CLOSE_USER_MENU_BUTTON}    xpath=//button[@aria-label="Close user menu"]
*** Keywords ***

