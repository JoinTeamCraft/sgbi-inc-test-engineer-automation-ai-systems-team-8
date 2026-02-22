*** Settings ***
Documentation     Template for Booking tests
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Resource          ../../resources/pages/home_page.robot
Resource          ../../resources/pages/search_result_page.robot
Resource          ../../resources/pages/car_details_page.robot

Test Teardown    Close All Browsers

*** Test Cases ***
Booking Test Template
    [Documentation]    Placeholder for booking test
    [Tags]    booking
    Log    Implement booking test here

TC_Navigation_To_Car_Details_Page_And_Validate_Car_Info
    [Documentation]    This test case validates that a user can navigate to the car details page from the search results and that the car information is displayed correctly
    [Tags]    booking
    Launch Application
    Navigate To Search Results Page
    ${Selected_car_name} =    Get Text    ${SEARCH_RESULT_PAGE_CAR_NAMES}
    Click Rent Now For First Car
    ${CAR_NAME}    ${CAR_PRICE}    Get Car Details Dynamically
    Should Be Equal    ${CAR_NAME}    ${Selected_car_name}
