*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          ../base/common_utility.robot
Resource          ../pages/home_page.robot

*** Variables ***

#====================================
# Search Result Page
#====================================
${RENT_NOW_BUTTON}              xpath=//button[.//span[text()='Rent Now']]
${SEARCH_RESULT_PAGE_CAR_NAMES}    xpath=//h3[contains(@class,'_product-card-header-title')]
*** Keywords ***
Navigate To Search Results Page
    [Documentation]    Navigates to the search results page by performing a car search from the home page with valid search criteria and validates that the search results are displayed by checking the visibility of car name elements on the search results page
    ${PICKUP_DATE}    ${RETURN_DATE} =    Get Random Pickup And Return Dates
    Perform Car Search home page    ${PICKUP_LOCATION}    ${DROPOFF_LOCATION}    ${PICKUP_DATE}    ${RETURN_DATE}
    Wait Until Element Is Visible    ${SEARCH_RESULT_PAGE_CAR_NAMES}    timeout=${MEDIUM_TIMEOUT}

Click Rent Now For First Car
    [Documentation]    Clicks the "Rent Now" button for the first car in the search results and validates that the user is navigated to the car details page by validating visibility of car name element on the details page
    Wait Until Element Is Visible    ${RENT_NOW_BUTTON}    ${SHORT_TIMEOUT}
    Wait Until Keyword Succeeds    ${MEDIUM_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    Click Button    ${RENT_NOW_BUTTON}
