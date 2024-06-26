*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN_URL}    https://id.atlassian.com/login
${DASHBOARD}    https://svvttestingproject.atlassian.net/jira/software/projects/KAN/boards/1
${EDITED_ISSUE_LINK}    https://svvttestingproject.atlassian.net/jira/software/projects/KAN/boards/1?selectedIssue=KAN-1
${VALID_EMAIL}    natnael.workuk@aastustudent.edu.et
${VALID_PASSWORD}    Password@02
${BROWSER}    chrome
${VALID_SUMMARY}    issue creation
${INVALID_EDITED_SUMMARY_NAME}    
${VALID_EDITED_SUMMARY_NAME}    edited name for summary

*** Test Cases ***
TC-FR3-01 Valid Issue Creation
    [Documentation]    Verify valid creation of an issue.
    Open BROWSER  ${DASHBOARD}   ${BROWSER}
    Login to jira
    Wait Until Element Is Visible    xpath=//input[@id='summary-field']    35s
    Input Text    id=summary-field    ${VALID SUMMARY}
    Click Button    xpath=//button[@type='submit']
    Wait Until Element Is Visible     xpath=//input[@name='search']     20s
    [Teardown]    Close Browser

TC-FR3-02 Missing Required Fields
    [Documentation]    Verify error message when required fields are empty.
    Open BROWSER  ${DASHBOARD}   ${BROWSER}
    Login to jira
    Wait Until Element Is Visible    xpath=//input[@id='summary-field']    35s
    Sleep    10s
    Click Button    xpath=//button[@type='submit']
    Wait Until Element Is Visible     xpath=//div[@id='summary-field-error']     20s
    [Teardown]    Close Browser

TC-FR4-01 Valid Issue Edit
    [Documentation]    Verify valid editing of an issue.
    Open Browser    ${EDITED_ISSUE_LINK}    ${BROWSER}
    Login to Jira
    Wait Until Element Is Visible    xpath=//button[@type='submit']    30s
    Sleep    20s
    Click Button    xpath=//button[@type='submit']
    Wait Until Element Is Visible     xpath=//input[@name='search']     20s
    [Teardown]    Close Browser

TC-FR4-02 Invalid Issue Edit
    [Documentation]    Verify valid editing of an issue.
    Open Browser    ${EDITED_ISSUE_LINK}    ${BROWSER}
    Login to Jira
    Wait Until Element Is Visible    xpath=//button[@type='submit']    30s
    Sleep    40s
    Click Button    xpath=//button[@type='submit']
    Wait Until Page Contains    You must specify a    20s
    [Teardown]    Close Browser
TC-FR5-01 Issue Deletetion
    [Documentation]    Verify valid Deletetion of an issue.
    Open BROWSER  ${DASHBOARD}   ${BROWSER}
    Login to Jira
    Sleep    100s
    Wait Until Element Is Visible     xpath=//input[@name='search']     20s
    [Teardown]    Close Browser






*** Keywords ***
Login to jira
    Wait Until Element Is Visible    xpath=//input[@name='username']    20s
    Input Text    xpath=//input[@name='username']    ${VALID EMAIL}
    Click Button    xpath=//button[@type='submit']
    Wait Until Element Is Visible    xpath=//input[@name='password']    20s
    Input Text    xpath=//input[@name='password']    ${VALID PASSWORD}
    Click Button    xpath=//button[@type='submit']