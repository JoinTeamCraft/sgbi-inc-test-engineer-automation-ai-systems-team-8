*** Settings ***
Documentation     Template for Search tests
Resource          ../../resources/pages/car_details_page.robot
Resource          ../../resources/pages/home_page.robot
Resource          ../../resources/pages/search_result_page.robot
Resource          ../../resources/base/common_utility.robot


Test Teardown    Close All Browsers

*** Test Cases ***
Search Test Template
    [Documentation]    Placeholder for search test
    [Tags]    search
    Log    Implement search test here

TC_Navigate_To_Car_Details_page_And_Verify_Car_Specifications
    [Documentation]    This test case validates that all car specifications are displayed and not empty on the car details page by iterating through the list of car info items and checking if the label and value for each item are present and not empty
    [Tags]    search
    Launch Application
    Navigate To Search Results Page
    Validate Search Results Are Displayed
    Click Rent Now For First Car
    Validate Car Specifications