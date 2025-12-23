# TestCodes\login_page.robot
*** Settings ***
# General documentation for this test suite
Documentation    Test cases for the login page of the SauceDemo website.

# Libraries used in this test suite
Library          SeleniumLibrary
Library          Collections
Library          String

# Variables files for locators and test data
Variables    ../Resources/Locators/test_locators.py
Variables    ../Resources/TestData/test_data.py

# Resource files for additional keyword definitions
Resource         ../Resources/Keywords/generic.robot
Resource         ../PageObject/KeywordDefinitionFiles/loginpage.robot
Resource    ../PageObject/KeywordDefinitionFiles/inventorypage.robot

# Setup actions before the test
Test Setup       Open Webpage URL    ${browser_name}    ${webpage_url}

# Teardown actions after the test
Test Teardown    Close The Browser



*** Test Cases ***

#TC-01 Login with various pre-defined users TC-03 validate logout functionality
Validate the multiple login users
    Enter User Credentials And Login    ${valid_username1}    ${valid_password}
    Verify HomePage Login
    Logout of the Webpage
    Enter User Credentials And Login    ${valid_username3}    ${valid_password}
    Verify HomePage Login
    Logout of the Webpage
    Enter User Credentials And Login    ${valid_username4}    ${valid_password}
    Verify HomePage Login
    Logout of the Webpage
    Enter User Credentials And Login    ${valid_username5}    ${valid_password}
    Verify HomePage Login
    Logout of the Webpage

# TC-02 Login with invalid credentials
Validate the Invalid Login Error Message
    [Tags]    ERRORMESSAGES
    Enter User Credentials And Login    ${invalid_username}    ${invalid_password}
    Verify Notification Message    ${login_error_element}    ${invalid_login_error_message}

# Test case to validate the error message when the username field is left blank
Validate the Blank Username Login Error Message
    [Tags]    ERRORMESSAGES
    Enter User Credentials And Login    ${blank_field}    ${valid_password}
    Verify Notification Message    ${login_error_element}    ${blank_user_error_message}

## Test case to validate the error message when the password field is left blank
Validate the Blank Password Login Error Message
    [Tags]    ERRORMESSAGES
    Enter User Credentials And Login    ${valid_username}    ${blank_field}
    Verify Notification Message    ${login_error_element}    ${blank_password_error_message}

