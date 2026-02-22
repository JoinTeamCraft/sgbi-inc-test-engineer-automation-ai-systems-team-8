*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          ../../resources/base/common_utility.robot

*** Variables ***

#====================================
# Search Result Page
#====================================
${RENT_NOW_BUTTON}              xpath=//button[.//span[text()='Rent Now']]
${SEARCH_RESULT_PAGE_CAR_NAMES}    xpath=//h3[contains(@class,'_product-card-header-title')]
*** Keywords ***
Click Rent Now For First Car
    [Documentation]    Clicks the "Rent Now" button for the first car in the search results and validates that the user is navigated to the car details page by validating visibility of car name element on the details page
    Wait Until Element Is Visible    ${RENT_NOW_BUTTON}    ${SHORT_TIMEOUT}
    Wait Until Keyword Succeeds    ${MEDIUM_TIMEOUT}    ${WAIT_RETRY_INTERVAL}    Click Button    ${RENT_NOW_BUTTON}
