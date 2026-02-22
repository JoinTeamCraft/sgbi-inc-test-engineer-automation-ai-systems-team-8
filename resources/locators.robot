*** Settings ***
<<<<<<< HEAD
Documentation     Locators for OrangeHRM application elements
Library           SeleniumLibrary

*** Variables ***
# Login Page Locators
${USERNAME_FIELD}        name=username
${PASSWORD_FIELD}        name=password
${LOGIN_BUTTON}          xpath=//button[@type='submit']
${ERROR_MESSAGE}         xpath=//div[@class='oxd-alert-content oxd-alert-content--error']
${INVALID_CREDENTIALS}   xpath=//p[contains(text(), 'Invalid credentials')]
${LOADING_SPINNER}       xpath=//div[@class='oxd-loading-spinner']

# Dashboard Page Locators  
${DASHBOARD_HEADER}      xpath=//h6[text()='Dashboard']
${USER_DROPDOWN}         xpath=//span[@class='oxd-userdropdown-tab']
${PROFILE_PICTURE}       xpath=//img[@class='oxd-userdropdown-img']
${MAIN_MENU}            xpath=//nav[@class='oxd-navbar-nav']

# Dashboard Widgets
${TIME_AT_WORK}         xpath=//p[text()='Time at Work']
${MY_ACTIONS}           xpath=//p[text()='My Actions']  
${QUICK_LAUNCH}         xpath=//p[text()='Quick Launch']

# Navigation Menu Items
${PIM_MENU}             xpath=//span[text()='PIM']
${LEAVE_MENU}           xpath=//span[text()='Leave']
${TIME_MENU}            xpath=//span[text()='Time']
${RECRUITMENT_MENU}     xpath=//span[text()='Recruitment']
${ADMIN_MENU}           xpath=//span[text()='Admin']

# User Dropdown Menu
${LOGOUT_LINK}          xpath=//a[text()='Logout']
${ABOUT_LINK}           xpath=//a[text()='About']
${SUPPORT_LINK}         xpath=//a[text()='Support']
${CHANGE_PASSWORD}      xpath=//a[text()='Change Password']

# Common Elements
${SEARCH_BUTTON}        xpath=//button[contains(@class, 'oxd-button--secondary')]
${RESET_BUTTON}         xpath=//button[contains(@class, 'oxd-button--ghost')]
${ADD_BUTTON}           xpath=//button[contains(text(), 'Add')]
${DELETE_BUTTON}        xpath=//button[contains(text(), 'Delete')]
${EDIT_BUTTON}          xpath=//button[contains(text(), 'Edit')]
=======
Documentation     Template for common locators
Library           SeleniumLibrary

*** Variables ***
# Add your application locators here
# ${EXAMPLE_LOCATOR}    id=example
>>>>>>> origin/master
