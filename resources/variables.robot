*** Settings ***
Documentation     Template for reusable keywords

*** Variables ***

${BROWSER}            chrome
${SHORT_TIMEOUT}    5s
${MEDIUM_TIMEOUT}   10s
${LONG_TIMEOUT}     30s
${WAIT_RETRY_INTERVAL}   500ms
#====================================
# TEST DATA - TC_Verify_Update_Profile_Functionality
#====================================
${FIRST_NAME}     Mo rent
${LAST_NAME}      Team Craft
${RESET_FIRST_NAME}     test
${RESET_LAST_NAME}      morent

#====================================
# ENVIRONMENT VARIABLES
#====================================
${BASE_URL}           %{MORENT_BASE_URL}
${USER_EMAIL}       %{MORENT_USER_EMAIL}
${USER_PASSWORD}    %{MORENT_USER_PASSWORD}
#=====================================

