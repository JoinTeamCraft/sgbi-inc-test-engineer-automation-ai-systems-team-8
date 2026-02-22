*** Settings ***
Documentation     Template for reusable keywords

*** Variables ***
${BASE_URL}           https://morent-car.archisacademy.com/
${BROWSER}            chrome
${SHORT_TIMEOUT}    5s
${MEDIUM_TIMEOUT}   10s
${LONG_TIMEOUT}     30s
${WAIT_RETRY_INTERVAL}   500ms
${USER_EMAIL}       doe+clerk_test@example.com
${USER_PASSWORD}    morenttest@12345
#====================================
# TEST DATA - TC_Verify_Update_Profile_Functionality
#====================================
${FIRST_NAME}     Morent
${LAST_NAME}      TeamCraft
${RESET_FIRST_NAME}     test
${RESET_LAST_NAME}      morent
