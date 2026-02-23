*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          ../base/common_utility.robot

*** Variables ***

#====================================
# CAR DETAILS PAGE
#====================================
${DETAILS_PAGE_CAR_NAME}          xpath=//h1[contains(@class,'_product-details-card-header-title')]
${DETAILS_PAGE_CAR_PRICE}          xpath=//p[contains(@class,'_product-price')]
#Below xpath points to all the car info items like car type, capacity, steering type and gasoline
${DETAILS_PAGE_CAR_INFO_ITEMS}
${CAR_IMAGE}    xpath=//div[contains(@class,'_product-image-viewer-main-image')]//img[@alt='main-image']

*** Keywords ***
Navigate to Car Details Page
    [Documentation]    Navigates to the car details page by clicking on the "Rent Now" button for the first car in the search results, Also validates that the car details page is loaded successfully by checking the visibility of car name and price elements
    Wait Until Element Is Visible    ${SEARCH_RESULT_PAGE_CAR_NAMES}    timeout=${MEDIUM_TIMEOUT}
    Click Rent Now For First Car
    Wait Until Element Is Visible    ${DETAILS_PAGE_CAR_NAME}    timeout=${MEDIUM_TIMEOUT}
    Wait Until Element Is Visible    ${DETAILS_PAGE_CAR_PRICE}   timeout=${SHORT_TIMEOUT}

Get Car Details Dynamically
    [Documentation]    Gets car name, price, and all info items dynamically
    Wait Until Page Contains Element    ${DETAILS_PAGE_CAR_NAME}    timeout=${MEDIUM_TIMEOUT}
    Wait Until Page Contains Element    ${DETAILS_PAGE_CAR_PRICE}   timeout=${SHORT_TIMEOUT}

    ${CAR_NAME}=    Get Text    ${DETAILS_PAGE_CAR_NAME}
    ${CAR_PRICE}=   Get Text    ${DETAILS_PAGE_CAR_PRICE}
    Log    Car Name: ${CAR_NAME}
    Log    Car Price: ${CAR_PRICE}

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

Verify Car Image On Car Details Page
    [Documentation]    Verifies the primary car image is displayed and loaded correctly and src attribute of the image is not empty which indicates image is loaded successfully, if image src is empty or image is not loaded successfully then it will log an error message indicating car image is broken or not loaded
    Wait Until Element Is Visible    ${CAR_IMAGE}    timeout=${MEDIUM_TIMEOUT}
    Element Should Be Visible       ${CAR_IMAGE}
    ${img_src}=    Get Element Attribute    ${CAR_IMAGE}    src
    Log    Car image src: ${img_src}
    Should Not Be Empty    ${img_src}    Car image src is empty, image may not have loaded
    Should Start With      ${img_src}    http



