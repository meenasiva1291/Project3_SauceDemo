# TestCodes\cart_page.robot
*** Settings ***
# General documentation for this test suite
Documentation    Test cases for the cart page of the SauceDemo website.

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
Resource         ../PageObject/KeywordDefinitionFiles/cartpage.robot

*** Test Cases ***
# TC-06 Test case to validate adding an item to the cart, TC - 07 validate product details inside the cart
Validate Add Item To Cart
    [Tags]    SMOKE    REGRESSION
    # Login to the webpage
    Login Into The Webpage
    # Add items to the cart
    Add Items To Cart    ${cart_list}
    # Go to the cart page
    Go To Cart
    # Verify the items in the cart
    Verify Items In Cart    ${cart_list}

# TC-06 Test case to validate adding an item to the cart, TC - 07 validate product details inside the cart
Validate Add Item Count To Cart
    Login Into The Webpage
    ${expected_items}=    Add Random 4 Items And Capture Details
    Element Text Should Be    ${cart_badge}    4
    Go To Cart
    ${actual_items}=    Get Item Names With Prices
    Should Be Equal    ${actual_items}    ${expected_items}

# Test case to validate removing an item from the cart
Validate Remove Item From Cart
    [Tags]    REGRESSION
    # Login to the webpage
    Login Into The Webpage
    # Add items to the cart
    Add Items To Cart    ${cart_list}
    # Go to the cart page
    Go To Cart
    # Remove items from the cart
    Remove Items From Cart    ${remove_list}