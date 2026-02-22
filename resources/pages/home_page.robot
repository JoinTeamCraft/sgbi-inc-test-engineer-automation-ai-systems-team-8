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

*** Keywords ***