*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          ../../resources/base/common_utility.robot

*** Variables ***

#====================================
# CAR DETAILS PAGE
#====================================
${DETAILS_PAGE_CAR_NAME}          xpath=//h1[contains(@class,'_product-details-card-header-title')]
${DETAILS_PAGE_CAR_PRICE}          xpath=//p[contains(@class,'_product-price')]
#Below xpath points to all the car info items like car type, capacity, steering type and gasoline
${DETAILS_PAGE_CAR_INFO_ITEMS}    //div[contains(@class,'_product-card-info-item')]

*** Keywords ***
Get Car Details Dynamically
    [Documentation]    Gets car name, price, and all info items dynamically
    Wait Until Page Contains Element    ${DETAILS_PAGE_CAR_NAME}    timeout=${MEDIUM_TIMEOUT}
    Wait Until Page Contains Element    ${DETAILS_PAGE_CAR_PRICE}   timeout=${SHORT_TIMEOUT}

    ${CAR_NAME}=    Get Text    ${DETAILS_PAGE_CAR_NAME}
    ${CAR_PRICE}=   Get Text    ${DETAILS_PAGE_CAR_PRICE}
    Log    Car Name: ${CAR_NAME}
    Log    Car Price: ${CAR_PRICE}
    Validate Car Specifications

    RETURN    ${CAR_NAME}    ${CAR_PRICE}

Validate Car Specifications
    [Documentation]    Validates that all car specifications are displayed and not empty on the car details page by iterating through the list of car info items and checking if the label and value for each item are present and not empty
    Wait Until Page Contains Element    ${DETAILS_PAGE_CAR_PRICE}   timeout=${SHORT_TIMEOUT}
    ${info_elements}=    Get WebElements    ${DETAILS_PAGE_CAR_INFO_ITEMS}
    ${x} =    Get Length    ${info_elements}
    FOR    ${i}    IN RANGE    ${x}
    ${label}=    Get Text    xpath=(${DETAILS_PAGE_CAR_INFO_ITEMS})[${i+1}]//label
    ${value}=    Get Text    xpath=(${DETAILS_PAGE_CAR_INFO_ITEMS})[${i+1}]//span
    Log    ${label}: ${value}
    Should Not Be Empty    ${value}
    END

