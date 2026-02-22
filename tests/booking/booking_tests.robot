*** Settings ***
Documentation     Template for Booking tests
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Resource          ../../resources/pages/home_page.robot
Resource          ../../resources/pages/search_result_page.robot
Resource          ../../resources/pages/car_details_page.robot

Test Setup        Car Detail Test Setup
Test Teardown     Close All Browsers

*** Keywords ***
Car Detail Test Setup
    [Documentation]    Common setup for booking tests: launch app, navigate to search results
    Launch Application
    Navigate To Search Results Page
    Click Rent Now For First Car

*** Test Cases ***
Booking Test Template
    [Documentation]    Placeholder for booking test
    [Tags]    booking
    Log    Implement booking test here

TC_Navigation_To_Car_Details_Page_And_Validate_Car_Info
    [Documentation]    This test case validates that a user can navigate to the car details page from the search results and that the car information is displayed correctly
    [Tags]    booking
    ${CAR_NAME}    ${CAR_PRICE}    Get Car Details Dynamically

TC_Navigate_To_Car_Details_page_And_Verify_Car_Specifications
    [Documentation]    This test case validates that all car specifications are displayed and not empty on the car details page by iterating through the list of car info items and checking if the label and value for each item are present and not empty
    [Tags]    booking
    Validate Car Specifications
