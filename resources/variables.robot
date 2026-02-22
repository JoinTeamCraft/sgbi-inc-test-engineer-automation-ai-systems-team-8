*** Settings ***
Documentation     Template for reusable keywords

*** Variables ***

${BROWSER}            chrome
#====================================
# WAIT variables - These can be used across the test cases for consistency and easy maintenance
#====================================
${SHORT_TIMEOUT}    5s
${MEDIUM_TIMEOUT}   10s
${LONG_TIMEOUT}     30s
${WAIT_RETRY_INTERVAL}   500ms
#====================================
# ENVIRONMENT VARIABLES
#====================================
${BASE_URL}           %{MORENT_BASE_URL}
${USER_EMAIL}       %{MORENT_USER_EMAIL}
${USER_PASSWORD}    %{MORENT_USER_PASSWORD}
#====================================
# TEST DATA - TC_Verify_Update_Profile_Functionality
#====================================
${FIRST_NAME}     Mo rent
${LAST_NAME}      Team Craft
#=====================================
# TEST DATA - Navigation To Car Details Page And Validate Car Info
#====================================
${PICKUP_LOCATION}    Ernakulam
${DROPOFF_LOCATION}    Ernakulam

