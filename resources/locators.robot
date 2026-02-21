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
${MANAGE_ACCOUNT_BUTTON}  xpath=//div[@role='menu']//button[normalize-space()='Manage account']
${SIGN_OUT_BUTTON}        xpath=//div[@role='menu']//button[normalize-space()='Sign out']
#====================================
# ACCOUNT > PROFILE PAGE
#====================================
${UPDATE_PROFILE_BUTTON}  xpath=//button[@data-localization-key="userProfile.start.profileSection.primaryButton"]
${FIRST_NAME}             id=firstName-field
${LAST_NAME}              id=lastName-field
${UPLOAD_PROFILE_IMAGE_BUTTON}    xpath=//button[@data-localization-key="userProfile.profilePage.imageFormSubtitle"]
${PROFILE_IMAGE}          xpath=//div[@role='dialog']//img[contains(@alt,"test morent")]
${ERROR_FIRST_NAME}       id=error-firstName
${ERROR_LAST_NAME}        id=error-lastName
${UPDATE_PROFILE_SAVE_BUTTON}    xpath=//button[@data-localization-key="userProfile.formButtonPrimary__save"]
${UPDATE_PROFILE_CANCEL_BUTTON}    xpath=//button[@data-localization-key="userProfile.formButtonReset"]
