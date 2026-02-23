*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          ../../resources/base/common_utility.robot
Resource           ../../resources/pages/car_details_page.robot
Resource          ../../resources/pages/search_result_page.robot

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
${HOME_CAR_CARD_NAME}        xpath=//h3[contains(@class,'_product-card-header-title')]
${HOME_RENT_NOW_BTN}         ${RENT_NOW_BUTTON}

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

Get Car Card Details Before Click
    [Documentation]    Gets the car name from the first car card on the home page before clicking the "Rent Now" button, this is used to validate that the correct car details are displayed on the car details page after clicking "Rent Now"
    Wait Until Element Is Visible    ${HOME_CAR_CARD_NAME}    timeout=${SHORT_TIMEOUT}
    ${car_name}=    Get Text    ${HOME_CAR_CARD_NAME}
    RETURN    ${car_name}

Click Rent Now Button On Car Card
    [Documentation]    Clicks the "Rent Now" button on the car card on the home page to navigate to the car details page
    Wait Until Element Is Visible    ${HOME_RENT_NOW_BTN}   timeout=${SHORT_TIMEOUT}
    Click Element    ${HOME_RENT_NOW_BTN}

Verify Car Details Page Loaded
    [Documentation]    Validates that the car details page is loaded successfully by checking the visibility of car name element on the details page
    Wait Until Page Contains Element    ${DETAILS_PAGE_CAR_NAME}    timeout=${MEDIUM_TIMEOUT}

Verify Car Information Matches Selected Card
    [Arguments]    ${expected_car_name}
    ${detail_car_name}=    Get Text    ${DETAILS_PAGE_CAR_NAME}
    Should Contain    ${detail_car_name}    ${expected_car_name}