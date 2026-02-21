*** Settings ***
Documentation     Template for common locators
Library           SeleniumLibrary

*** Variables ***
# Add your application locators here
# ${EXAMPLE_LOCATOR}    id=example
#====================================
# HOME PAGE
#====================================
${SIGNIN_BUTTON}          xpath=//button[@component='SignInButton']
${ACCOUNT_BUTTON}         xpath=//button[@aria-label="Open user menu"]
#====================================
# USER ACCOUNT POP UP
#====================================
${MANAGE_ACCOUNT_BUTTON}         xpath=//div[@role='menu']//button[normalize-space()='Manage account']
${SIGN_OUT_BUTTON}        xpath=//div[@role='menu']//button[normalize-space()='Sign out']
#====================================
# ACCOUNT > PROFILE PAGE
#====================================
${UPDATE_PROFILE_BUTTON}  xpath=//button[@data-localization-key="userProfile.start.profileSection.primaryButton"]
