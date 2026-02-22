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
    [Documentation]    Common setup for booking tests: launch app, navigate to search results, and store first car name
    Launch Application
    Navigate To Search Results Page
    ${Selected_car_name}=    Get Text    ${SEARCH_RESULT_PAGE_CAR_NAMES}
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
    ${Selected_car_name} =    Car Detail Test Setup
    ${CAR_NAME}    ${CAR_PRICE}    Get Car Details Dynamically
    Should Be Equal    ${CAR_NAME}    ${Selected_car_name}

TC_Navigate_To_Car_Details_page_And_Verify_Car_Specifications
    [Documentation]    This test case validates that all the essential elements on the car details page are displayed correctly, including car name, price, features, and booking options
    [Tags]    booking
    Car Detail Test Setup
    Validate Car Specifications
