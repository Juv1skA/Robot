*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource    ../resources/keywords.robot
Suite Setup    Open Browser To Example Site
Suite Teardown    Close Browser

*** Variables ***
${URL}    https://practice.expandtesting.com
${BROWSER}    Edge
${USERNAME}    practice
${PASSWORD}    SuperSecretPassword!
@{FORM_DATA}    &{FORM_DATA_1}    &{FORM_DATA_2}    &{FORM_DATA_3}    &{FORM_DATA_4}
&{FORM_DATA_1}    name=John Doe    email=john.doe@example.com    message=Hello, this is John.
&{FORM_DATA_2}    name=Jane Smith    email=jane.smith@example.com    message=Hi, this is Jane.
&{FORM_DATA_3}    name=Alice Brown    email=alice.brown@example.com    message=Greetings from Alice.
&{FORM_DATA_4}    name=Bob White    email=bob.white@example.com    message=Message from Bob.
${CSV_FILE}    results/form_submission_results.csv


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

Contact Submission Test
    [Documentation]    This test fills out a contact page 4 times and saves the results to a CSV file.
    Create File    ${CSV_FILE}    Name,Email,Message
    Go To    ${URL}/contact
    FOR    ${data}    IN    @{FORM_DATA}
        Fill Contact Form    ${data["name"]}    ${data["email"]}    ${data["message"]}
    END

*** Keywords ***
Open Browser To Example Site
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Close Browser
    Close Browser

Fill Contact Form
    [Arguments]    ${name}    ${email}    ${message}
    Input Text    //label[contains(text(),'Name')]/following-sibling::input    ${name}
    Input Text    //label[contains(text(),'Email')]/following-sibling::input    ${email}
    Input Text    //label[contains(text(),'You message')]/following-sibling::textarea    ${message}
    Append To File    ${CSV_FILE}    ${name},${email},${message}\n
    Sleep    1s
