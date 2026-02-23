*** Settings ***
Documentation     Template for Booking tests
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Resource          ../../resources/pages/home_page.robot
Resource          ../../resources/pages/search_result_page.robot
Resource          ../../resources/pages/car_details_page.robot

Test Setup    Car Detail Test Setup
Test Teardown    Close All Browsers

*** Keywords ***

Car Detail Test Setup
    [Documentation]    Common setup for booking tests: launch app, navigate to search results, and store first car name and click rent now
    Launch Application
    Navigate To Search Results Page
    ${Selected_car_name}=    Get Text    ${SEARCH_RESULT_PAGE_CAR_NAMES}
    Set Suite Variable    ${SELECTED_CAR_NAME}    ${selected_car_name}
    Click Rent Now For First Car
    RETURN    ${Selected_car_name}

*** Test Cases ***
Booking Test Template
    [Documentation]    Placeholder for booking test
    [Tags]    booking
    Log    Implement booking test here

TC_Navigation_To_Car_Details_Page_And_Validate_Car_Info
    [Documentation]    This test case validates that a user can navigate to the car details page from the search results and that the car information is displayed correctly
    [Tags]    booking
    ${CAR_NAME}    ${CAR_PRICE}    Get Car Details Dynamically
    Should Be Equal    ${CAR_NAME}    ${SELECTED_CAR_NAME}

TC_Navigate_To_Car_Details_page_And_Verify_Car_Specifications
    [Documentation]    This test case validates that all the essential elements on the car specifications section of the car details page are displayed and contain valid information by iterating through the list of car info items and checking if the label and value for each item are present and not empty
    [Tags]    booking
    Validate Car Specifications

TC_Navigate_To_Car_Details_Page_and_Verify_Image
    [Documentation]    This test case validates that the car image is displayed on the car details page and that the image source is not empty, ensuring that the car image is loaded correctly
    [Tags]    booking
    Wait Until Page Contains Element    ${DETAILS_PAGE_CAR_NAME}    timeout=${MEDIUM_TIMEOUT}
    Verify Car Image On Car Details Page