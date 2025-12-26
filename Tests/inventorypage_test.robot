# TestCodes\inventory_page.robot
*** Settings ***
# General documentation for this test suite
Documentation    Test cases for the inventory page of the SauceDemo website.

# Libraries used in this test suite
Library          SeleniumLibrary
Library          Collections
Library          String

# Setup actions before the test
Test Setup       Open Webpage URL    ${browser_name}    ${webpage_url}

# Teardown actions after the test
Test Teardown    Close The Browser

# Variables files for locators and test data
Variables    ../Resources/Locators/test_locators.py
Variables    ../Resources/TestData/test_data.py

# Resource files for additional keyword definitions
Resource         ../Resources/Keywords/generic.robot
Resource         ../PageObject/KeywordDefinitionFiles/loginpage.robot
Resource         ../PageObject/KeywordDefinitionFiles/inventorypage.robot


*** Test Cases ***

# TC-04 - Test case to validate cart icon visiblity
Validate cart icon
    [Tags]    REGRESSION
    # Login to the webpage
    Login Into The Webpage
    # Check the visibility of cart icon
    Cart icon visibility

# TC-09 - Test case to validate sort operations, TC-05 - Random selection of products
Validate Sort Operations
    [Tags]    REGRESSION
    # Login to the webpage
    Login Into The Webpage
    # Select sort option A-Z and check product order
    Select Sort Option    0
    Check The Products Order A-Z
    # Select sort option Z-A and check product order
    Select Sort Option    1
    Check The Products Order Z-A
    # Select sort option Low to High and check product order
    Select Sort Option    2
    Check The Products Order Low To High
    # Select sort option High to Low and check product order
    Select Sort Option    3
    Check The Products Order High To Low

# Test case randomly select items
Validate items added randomly
    [Tags]    SMOKE
    # Login to the webpage
    Login Into The Webpage
    # fetch items name with prices
    Get Random 4 Items With Prices

Validate items added randomly and verify cart
    [Tags]    SMOKE

    Login Into The Webpage
    Add Random 4 Items To Cart
    # Verify cart badge count
    Element Text Should Be    ${cart_badge}    4


# Test case to validate successful logout
Validate Successful Logout
    [Tags]    SMOKE
    # Login to the webpage
    Login Into The Webpage
    # Logout of the webpage
    Logout of the Webpage

# Test case to validate the About option
Validate About Option
    [Tags]    REGRESSION
    # Login to the webpage
    Login Into The Webpage
    # Verify the About tab
    Verify About Tab

# TC-10 - Test case to validate Reset App State option
Validate Reset App State Option
    [Tags]    REGRESSION
    # Login to the webpage
    Login Into The Webpage
    # Add items to the cart
    Add Items To Cart    ${cart_list}
    # Reset the webpage
    Reset App Webpage
    # Verify the reset of the webpage
    Verify Reset Of Webpage