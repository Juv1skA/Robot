*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/keywords.robot
Suite Setup    Open Browser To Example Site
Suite Teardown    Close Browser

*** Variables ***
${URL}    https://practice.expandtesting.com
${BROWSER}    Edge
${USERNAME}    practice
${PASSWORD}    SuperSecretPassword!

*** Test Cases ***
Login Test
    [Documentation]    This test checks the login functionality of the example website.
    Login To Website
    Capture Page Screenshot    results/login_test_screenshot.png

Select Radio Button Test
    [Documentation]    This test checks selecting a radio button.
    Go To    ${URL}/radio-buttons
    Select Radio Button    color    red
    Select Radio Button    sport    football
    Wait Until Element Is Enabled    id=red    timeout=5s
    Wait Until Element Is Enabled    id=football    timeout=5s
    Capture Page Screenshot    results/select_radio_button_test.png

Dropdown Selection Test
    [Documentation]    This test selects an option from a dropdown.
    Go To    ${URL}/dropdown
    Select From List By Value    id=dropdown    1
    Select From List By Value    id=country    FI
    Capture Page Screenshot    results/dropdown_selection_test.png

*** Keywords ***
Open Browser To Example Site
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Close Browser
    Close Browser