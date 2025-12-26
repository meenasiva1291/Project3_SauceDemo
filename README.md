Project3_SauceDemo – Robot Framework Automation

**Table of Contents**

#Project Overview
#Tech Stack
#Project Structure

4. Test Scenarios Covered

5. Key Features

6. How to Run the Tests

7. Test Reports

8. Configuration

**Project Overview**

This project is an end-to-end test automation framework built using Robot Framework and SeleniumLibrary to automate the SauceDemo web application.

The framework follows the Page Object Model (POM) design pattern, ensuring:

High reusability

Easy maintenance

Clear separation of test logic and page actions

**Tech Stack**

Robot Framework

Python

SeleniumLibrary

Chrome / ChromeDriver

PyCharm / VS Code

**Project Structure**

Project3_SauceDemo

<img width="737" height="641" alt="image" src="https://github.com/user-attachments/assets/abeb9037-772d-4adc-a17f-ecf25de8cee5" />


**Test Scenarios Covered**

Login validation (valid & invalid)

Inventory page validation

Random item selection and add to cart

Cart item count verification

Cart item name & price validation

Checkout flow validation

Total price verification

**Key Features**

✔ Page Object Model (POM)

✔ Reusable custom keywords

✔ Random item selection logic

✔ Name & price comparison between inventory and cart

✔ Clean reporting (log.html & report.html)

✔ Regression & smoke test tagging

▶️ **How to Run the Tests**

1️⃣ Install Dependencies
pip install robotframework
pip install robotframework-seleniumlibrary

2️⃣ Verify Chrome & ChromeDriver
Ensure Chrome browser and matching ChromeDriver are installed and available in PATH.

3️⃣ Run All Tests
robot Tests/

4️⃣ Run a Specific Test File
robot Tests/cartpage_test.robot

5️⃣ Run Tests by Tag
robot --include SMOKE Tests/
robot --include REGRESSION Tests/


**Configuration**

Locators are maintained in:
Resources/Locators/test_Locators.py

Common reusable keywords are in:
Resources/Keywords/generic.robot
