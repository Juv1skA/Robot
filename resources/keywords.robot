*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://practice.expandtesting.com
${BROWSER}    Edge
${USERNAME}    practice
${PASSWORD}    SuperSecretPassword!

*** Keywords ***
Login To Website
    Go To    ${URL}/login
    Input Text    id=username    ${USERNAME}
    Input Text    id=password    ${PASSWORD}
    Scroll Element Into View    id=login
    Click Button    Login
    Wait Until Page Contains    You logged into a secure area!    timeout=10s
    Sleep    2s