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
${HOME_PAGE_PICK_UP_LOCATION}    xpath=//*[contains(normalize-space(text()),'Pick')]/ancestor::*[contains(@class,'_range-card-section')]//div[@aria-label='Select your City']
${HOME_PAGE_DROP_OFF_LOCATION}    xpath=//*[contains(normalize-space(text()),'Drop')]/ancestor::*[contains(@class,'_range-card-section')]//div[@aria-label='Select your City']
${HOME_PAGE_PICK_UP_DATE}    xpath=//div[contains(@class,'_range-card-section') and .//*[contains(normalize-space(text()),'Pick')]]//input[@placeholder='Select date']
${HOME_PAGE_DROP_OFF_DATE}    xpath=//div[contains(@class,'_range-card-section') and .//*[contains(normalize-space(text()),'Drop')]]//input[@placeholder='Select date']
${HOME_PAGE_SEARCH_BUTTON}    xpath=//button[normalize-space()='Search']

*** Keywords ***

Perform Car Search home page
    [Documentation]    Fills in the search form on the home page with the
    ...                provided parameters and submits it.
    [Arguments]
    ...    ${PICKUP_LOCATION}
    ...    ${DROPOFF_LOCATION}
    ...    ${PICKUP_DATE}
    ...    ${RETURN_DATE}

    Wait Until Element Is Enabled    ${HOME_PAGE_SEARCH_BUTTON}
    Wait Until Keyword Succeeds    ${LONG_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    Select Dropdown Option By Name    ${HOME_PAGE_PICK_UP_LOCATION}    ${PICKUP_LOCATION}
    Input Text        ${HOME_PAGE_PICK_UP_DATE}    ${PICKUP_DATE}
    Select Dropdown Option By Name        ${HOME_PAGE_DROP_OFF_LOCATION}    ${DROPOFF_LOCATION}
    Input Text        ${HOME_PAGE_DROP_OFF_DATE}    ${RETURN_DATE}
    Click Button      ${HOME_PAGE_SEARCH_BUTTON}

    Log    Search form filled — Pickup: ${PICKUP_LOCATION}, Drop-off: ${DROPOFF_LOCATION}