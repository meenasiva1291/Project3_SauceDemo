# Resources\PageObject\KeywordDefinitionFiles\inventorypage.robot
*** Settings ***
# General documentation for this file
Documentation    This file contains detailed keyword definitions specifically designed for testing the various features of the inventory page on the SauceDemo website.

# Libraries used in this file
Library          SeleniumLibrary
Library          Collections

# Variables files for locators and test data
Variables    ../../Resources/Locators/test_locators.py
Variables    ../../Resources/TestData/test_data.py

*** Keywords ***

#keyword to validate cart icon
Cart icon visibility
    Wait Until Element Is Visible    ${cart_button}
    Capture Page Screenshot

# Keyword to log out of the webpage
Logout of the Webpage
    Click Button    ${menu_button}
    Wait Until Element Is Visible    ${logout_button}
    Click Element    ${logout_button}

# Keyword to verify the About tab
Verify About Tab
    Click Button    ${menu_button}
    Wait Until Element Is Visible    ${about_button}
    Click Element    ${about_button}
    Location Should Be    ${about_url}
    Go Back

# Keyword to check the footer widget links
Check Footer Widget Links
    @{elements_list}=    Get Webelements    ${footer_widgets}
    FOR    ${element}    IN    @{elements_list}
        Click Element    ${element}
        Switch Window    NEW
        ${index} =    Set Variable    0
        ${location} =    Get Location
        Run Keyword If    '${location}' == '${widget_urls}[${index}]'    Log    'Correct URL opened: ${location}'
            Close Window
            Switch Window    MAIN
            ${index} =    Evaluate    ${index} + 1
    END

# Keyword to select a sort option
Select Sort Option
    [arguments]    ${index}
    Select From List By Index    ${products_sort_locator}    ${index}

# Keyword to collect a list of elements
Collect List Of Elements
    @{elements} =    Get Webelements    ${itemList_locator}
    ${list} =    Create List
    FOR    ${element}    IN    @{elements}
        ${text} =    Get Text    ${element}
        Log    ${text}    # Log the value to verify it's correctly fetched and converted
        Append To List    ${list}    ${text}
    END
    RETURN    ${list}

 # Keyword to collect a list of elements
Collect price List Of Elements
    @{elements} =    Get Webelements    ${itemPrice_locator}
    ${list} =    Create List
    FOR    ${element}    IN    @{elements}
        ${text} =    Get Text    ${element}
        Log    ${text}    # Log the value to verify it's correctly fetched and converted
        Append To List    ${list}    ${text}
    END
    Log To Console    Final list = ${list}
    RETURN    ${list}

*** Keywords ***
#Get Item Names With Prices
#    @{names}=     Get WebElements    ${itemList_locator}
#    @{prices}=    Get WebElements    ${itemPrice_locator}
#
#    ${items}=     Create List
#    ${count}=     Get Length    ${names}
#
#    FOR    ${index}    IN RANGE    ${count}
#        ${name}=     Get Text    ${names}[${index}]
#        ${price}=    Get Text    ${prices}[${index}]
#        ${item}=     Catenate    SEPARATOR= :    ${name}    ${price}
#        Append To List    ${items}    ${item}
#        Log To Console    ${item}
#    END
#
#    RETURN    ${items}



*** Keywords ***
Get Random 4 Items With Prices
    @{name_elements}=     Get WebElements    css:div.inventory_item_name
    @{price_elements}=    Get WebElements    css:div.inventory_item_price

    ${count}=    Get Length    ${name_elements}
    Should Be True    ${count} >= 4    Not enough items to select random 4

    # Generate random indexes
    ${indexes}=    Evaluate    random.sample(range($count), 4)    random

    ${items}=    Create List

    FOR    ${i}    IN    @{indexes}
        ${name}=     Get Text    ${name_elements}[${i}]
        ${price}=    Get Text    ${price_elements}[${i}]
        ${item}=     Catenate    SEPARATOR= :    ${name}    ${price}
        Append To List    ${items}    ${item}
        Log To Console    ${item}
    END

    RETURN    ${items}

*** Keywords ***
Add Random 4 Items To Cart
    @{add_buttons}=    Get WebElements    css:button.btn_inventory
    ${count}=          Get Length    ${add_buttons}

    Should Be True    ${count} >= 4    Not enough items to add

    ${indexes}=    Evaluate    random.sample(range($count), 4)    random

    FOR    ${i}    IN    @{indexes}
        Click Element    ${add_buttons}[${i}]
        Log To Console    Added item at index ${i}
    END

    RETURN

 Add Random 4 Items And Capture Details
    @{names}=         Get WebElements    ${itemList_locator}
    @{prices}=        Get WebElements    ${itemPrice_locator}
    @{add_buttons}=   Get WebElements    css:button.btn_inventory

    ${count}=    Get Length    ${add_buttons}
    Should Be True    ${count} >= 4    Not enough items to add

    ${indexes}=    Evaluate    random.sample(range($count), 4)    random
    ${items}=      Create List

    FOR    ${i}    IN    @{indexes}
        ${name}=     Get Text    ${names}[${i}]
        ${price}=    Get Text    ${prices}[${i}]
        Click Element    ${add_buttons}[${i}]
        ${item}=    Create Dictionary    name=${name}    price=${price}
        Append To List    ${items}    ${item}
    END

    RETURN    ${items}


# Keyword to check the products order A-Z
Check The Products Order A-Z
    @{item_names} =    Create List    @{inventory_items.keys()}
    Log    ${item_names}
    ${expected_list}=    Evaluate    sorted(${item_names}, reverse=False)
    Log    ${expected_list}    # Log the expected list to confirm it is correct
    @{current_items} =    Get Webelements    ${itemList_locator}
    @{current_list} =    Create List
    FOR    ${element}    IN    @{current_items}
        ${text} =    Get Text    ${element}
        Log    ${text}    # Log the text to verify it is correctly fetched
        Append To List    ${current_list}    ${text}
    END
    Log    ${current_list}    # Log the current list to see what is fetched
    Lists Should Be Equal    ${expected_list}    ${current_list}

# Keyword to check the products order Z-A
Check The Products Order Z-A
    @{item_names} =    Create List    @{inventory_items.keys()}
    Log    ${item_names}
    ${expected_list}=    Evaluate    sorted(${item_names}, reverse=True)
    Log    ${expected_list}    # Log the expected list to confirm it is correct
    @{current_items} =    Get Webelements    ${itemList_locator}
    @{current_list} =    Create List
    FOR    ${element}    IN    @{current_items}
        ${text} =    Get Text    ${element}
        Log    ${text}    # Log the text to verify it is correctly fetched
        Append To List    ${current_list}    ${text}
    END
    Log    ${current_list}    # Log the current list to see what is fetched
    Lists Should Be Equal    ${expected_list}    ${current_list}

# Keyword to check the products order from Low to High
Check The Products Order Low To High
    # Creating the expected list of prices
    @{prices} =    Create List    @{inventory_prices.keys()}
    Log    ${prices}    # Log the prices to confirm they are correct
    ${sorted_list} =    Evaluate    sorted(${prices})
    Log    ${sorted_list}    # Log the sorted expected list to confirm order
    # Fetching respective product names in expected order and flatten the list
    @{product_names} =    Create List
    FOR    ${price}    IN    @{sorted_list}
        ${product} =    Evaluate    [value for key, value in &{inventory_prices}.items() if key == ${price}][0]
        FOR    ${item}    IN    @{product}
            Append To List    ${product_names}    ${item}
        END
    END
    Log    ${product_names}    # Log the product names to confirm the order
    ${current_list} =    Collect List Of Elements
    Lists Should Be Equal    ${product_names}    ${current_list}

# Keyword to check the products order from High to Low
Check The Products Order High To Low
    # Creating the expected list of prices
    @{prices} =    Create List    @{inventory_prices.keys()}
    Log    ${prices}    # Log the prices to confirm they are correct
    ${sorted_list} =    Evaluate    sorted(${prices}, reverse=True)
    Log    ${sorted_list}    # Log the sorted expected list to confirm order
    # Fetching respective product names in expected order and flatten the list
    @{product_names} =    Create List
    FOR    ${price}    IN    @{sorted_list}
        ${product} =    Evaluate    [value for key, value in &{inventory_prices}.items() if key == ${price}][0]
        FOR    ${item}    IN    @{product}
            Append To List    ${product_names}    ${item}
        END
    END
    Log    ${product_names}    # Log the product names to confirm the order
    ${current_list} =    Collect List Of Elements
    Lists Should Be Equal    ${product_names}    ${current_list}

# Keyword to add items to the cart
Add Items To Cart
    [arguments]    ${list}
    FOR    ${item}    IN    @{list}
        ${locator} =    Get From Dictionary    ${inventory_items}    ${item}
        Click Button    ${locator}
    END

# Keyword to navigate to the cart page
Go To Cart
    Click Element    ${cart_button}
    Location Should Be    ${cart_page_url}

# Keyword to reset the app webpage
Reset App Webpage
    Click Button    ${menu_button}
    Wait Until Element Is Visible    ${reset_button}
    Click Element    ${reset_button}

# Keyword to verify the reset of the webpage
Verify Reset Of Webpage
    Page Should Not Contain Element    ${cart_badge}
