# Resources\PageObject\KeywordDefinitionFiles\cartpage.robot
*** Settings ***
# General documentation for this file
Documentation    This file contains detailed keyword definitions specifically designed for testing the various features of the cart page on the SauceDemo website.

# Libraries used in this file
Library          SeleniumLibrary
Library          Collections

# Variables files for locators and test data
Variables    ../../Resources/Locators/test_locators.py
Variables    ../../Resources/TestData/test_data.py

# Resource files for additional keyword definitions
Resource         ../KeywordDefinitionFiles/inventorypage.robot

*** Keywords ***
# Keyword to verify items in the cart
Verify Items In Cart
    [arguments]    ${list}
    # Collect the list of current items in the cart
    ${current_items} =    Collect List Of Elements
    # Check if the collected items are equal to the expected list
    Lists Should Be Equal    ${list}    ${current_items}

Get Item Names With Prices
    @{names}=     Get WebElements    ${itemList_locator}
    @{prices}=    Get WebElements    ${itemPrice_locator}

    ${count}=    Get Length    ${names}
    ${items}=    Create List

    FOR    ${i}    IN RANGE    0    ${count}
        ${name}=     Get Text    ${names}[${i}]
        ${price}=    Get Text    ${prices}[${i}]

        ${item}=    Create Dictionary    name=${name}    price=${price}
        Append To List    ${items}    ${item}

        Log To Console    Cart → ${name} | ${price}
    END

    RETURN    ${items}
    Wait Until Page Contains     @{names}

# Keyword to verify items in the cart
Verify Items count In Cart
    [arguments]    ${list}
    # Collect the list of current items in the cart
    ${current_items} =    Add Random 4 Items To Cart
    # Check if the collected items are equal to the expected list
    Lists Should Be Equal    ${list}    ${current_items}

# Keyword to remove items from the cart
Remove Items From Cart
    [arguments]    ${list}
    # Loop through each item in the list
    FOR    ${item}    IN    @{list}
        # Get the locator for the remove button of the item
        ${locator} =    Get From Dictionary    ${items_remove_button}    ${item}
        # Click the remove button
        Click Button    ${locator}
    END
    # Collect the list of current items in the cart after removal
    ${cart_items} =    Collect List Of Elements
    # Log the current cart items for debugging purposes
    Log    ${cart_items}
    # Verify that the removed items are no longer in the cart
    FOR    ${item}    IN    @{list}
        List Should Not Contain Value    ${cart_items}    ${item}
    END
