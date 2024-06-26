*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN URL}    https://id.atlassian.com/login
${VALID EMAIL}    natnael.workuk@aastustudent.edu.et
${VALID PASSWORD}    Password@02
${INVALID PASSWORD}    invalid_password
${INVALID EMAIL}    invalid_emailexa@mple.com
${User Name}        Natnael Worku
${BROWSER}      chrome

*** Test Cases ***

TC-FR2-01 Valid User Login
    [Documentation]    Verify that a user can successfully log in with valid credentials.
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Wait Until Element Is Visible    xpath=//input[@name='username']    20s
    Input Text    xpath=//input[@name='username']    ${VALID EMAIL}
    Click Button    xpath=//button[@type='submit']
    Wait Until Element Is Visible    xpath=//input[@name='password']    20s
    Input Text    xpath=//input[@name='password']    ${VALID PASSWORD}
    Click Button    xpath=//button[@type='submit']
    Wait Until Page Contains    G'day, ${User Name}    20s
    [Teardown]    Close Browser

TC-FR2-02 Invalid Password
    [Documentation]    Verify that login fails with an invalid password.
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Wait Until Element Is Visible    xpath=//input[@name='username']    20s
    Input Text    xpath=//input[@name='username']    ${VALID EMAIL}
    Click Button    xpath=//button[@type='submit']
    Wait Until Element Is Visible    xpath=//input[@name='password']    20s
    Input Text    xpath=//input[@name='password']    ${INVALID PASSWORD}
    Click Button    xpath=//button[@type='submit']
    Wait Until Page Contains    Incorrect email address and / or password.    20s
    [Teardown]    Close Browser

TC-FR2-03 Invalid Email
    [Documentation]    Verify that login fails with an invalid email.
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Wait Until Element Is Visible    xpath=//input[@name='username']    20s
    Input Text    xpath=//input[@name='username']    ${INVALID EMAIL}
    Click Button    xpath=//button[@type='submit']
    Wait Until Element Is Visible    xpath=//input[@name='password']    20s
    Input Text    xpath=//input[@name='password']    ${VALID PASSWORD}
    Click Button    xpath=//button[@type='submit']
    Wait Until Page Contains    Incorrect email address and / or password.    20s
    [Teardown]    Close Browser