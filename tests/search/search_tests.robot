*** Settings ***
Documentation     Template for Search tests
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Resource          ../../resources/pages/home_page.robot
Resource          ../../resources/pages/search_result_page.robot
Resource          ../../resources/pages/car_details_page.robot

Test Teardown    Close All Browsers

*** Test Cases ***
Search Test Template
    [Documentation]    Placeholder for search test
    [Tags]    search
    Log    Implement search test here

TC_Verify Rent Now Button Navigation from Home Page Car Card
    [Documentation]    This test case validates that clicking the "Rent Now" button on a car card from the home page successfully navigates the user to the car details page and that the car name on the details page matches the selected car name from the home page
    [Tags]    details
    Launch Application
    ${CAR_NAME}    Get Car Card Details Before Click
    Click Rent Now Button On Car Card
    Verify Car Details Page Loaded
    Verify Car Information Matches Selected Card    ${CAR_NAME}