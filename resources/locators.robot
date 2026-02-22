*** Settings ***
Documentation     Template for common locators
Library           SeleniumLibrary

*** Variables ***
# Add your application pages here
# ${EXAMPLE_LOCATOR}    id=example
#====================================
# LOGIN PAGE
#====================================
${LOGIN_EMAIL_INPUT}      id=identifier-field
${LOGIN_PASSWORD_INPUT}   id=password-field
${CONTINUE_BUTTON}        xpath=//form//button[@data-localization-key='formButtonPrimary']
#====================================
# HOME PAGE
#====================================
${SIGNIN_BUTTON}          xpath=//button[@component='SignInButton']
${ACCOUNT_BUTTON}         xpath=//button[@aria-label="Open user menu"]
#====================================
# USER ACCOUNT POP UP
#====================================
${USER_PREVIEW_NAME}      xpath=//div[@role='dialog']//span[contains(@class,'userPreviewMainIdentifierText')]
${MANAGE_ACCOUNT_BUTTON}  xpath=//div[@role='menu']//button[normalize-space()='Manage account']
${SIGN_OUT_BUTTON}        xpath=//div[@role='menu']//button[normalize-space()='Sign out']
