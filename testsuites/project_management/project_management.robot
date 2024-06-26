*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${VALID_EMAIL}    natnael.workuk@aastustudent.edu.et
${VALID_PASSWORD}    Password@02
${BROWSER}    chrome
${DASHBOARD}    https://svvttestingproject.atlassian.net/jira/software/projects/KAN/boards/1
${VALID_SUMMARY}    Test project
${VALID_KEY}        TPR
${INVALID_KEY}      ${EMPTY}
${VALID_KEY_2}      QWE
${VALID_SUMMARY_2}      test it

${VALID_PROJECT_EDIT_SETTING}      https://svvttestingproject.atlassian.net/jira/software/projects/ETP/settings/details 
${INVALID_PROJECT_EDIT_SETTING}      https://svvttestingproject.atlassian.net/jira/software/projects/IET/settings/details
${VALID_PRJECT_EDIT_SUMMARY}    new edited name
${VALID_PRJECT_EDIT_SUMMARY_2}  setting edit new
${VALID_PROJECT_EDIT_KEY}       NEN
${VALID_PROJECT_EDIT_KEY_2}     SEN
${ACCESS_EDIT_LINK}        https://svvttestingproject.atlassian.net/jira/software/projects/IET/settings/access 
${ADDED_USER}      ja72dksj@gmail.com


*** Test Cases ***
TC-FR6-01 VALID project Creation
    [Documentation]    Verify valid creation of a project.
    
    Open BROWSER  ${DASHBOARD}   ${BROWSER}
    Login to jira
    Sleep      40s
    Wait Until Element Is Visible    xpath=//input[@name='project-name']    20s
    Input Text    name=project-name    ${VALID_SUMMARY}
    Input Text    name=key-field-project-create    ${VALID_KEY}
    Sleep       15s
    Wait Until Element Is Visible     xpath=//input[@name='search']     20s
    Wait Until Page Contains    ${VALID_SUMMARY}    20s
    [Teardown]    Close Browser

TC-FR6-02 Invalid project creation due to Missing summary
    [Documentation]    Verify that it shows error when summary is Missing.
    
    Open BROWSER  ${DASHBOARD}   ${BROWSER}
    Login to jira
    Sleep      40s
    Wait Until Element Is Visible    xpath=//input[@name='key-field-project-create']    20s
    Input Text    name=key-field-project-create    ${VALID_KEY_2}
    Sleep       15s
    Wait Until Page Contains    Your project must have a name    20s
    [Teardown]    Close Browser
TC-FR6-03 Invalid project creation due to duplicate summary
    [Documentation]    Verify that it shows error when summary is duplicate or project with that name exists.
    
    Open BROWSER  ${DASHBOARD}   ${BROWSER}
    Login to jira
    Sleep      40s
    Wait Until Element Is Visible    xpath=//input[@name='project-name']    20s
    Input Text    name=project-name    ${VALID_SUMMARY}
    Wait Until Page Contains    A project with that name already exists    20s
    [Teardown]    Close Browser

TC-FR6-04 Invalid project creation due to Missing key
    [Documentation]    Verify invalid creation of a project due to Missing key.
   
    Open BROWSER  ${DASHBOARD}   ${BROWSER}
    Login to jira
    Sleep      40s
    Wait Until Element Is Visible    xpath=//input[@name='project-name']    20s
    Input Text    name=project-name    ${VALID_SUMMARY_2}
    Input Text    name=key-field-project-create    ${INVALID KEY}
    Sleep   2s
    Wait Until Page Contains    Your project must have a key    20s
    [Teardown]    Close Browser


TC-FR7-01 valid edit of project details
    [Documentation]     verify the system allows edition of important details such as summary and key
    
    Open BROWSER       ${VALID_PROJECT_EDIT_SETTING}      ${BROWSER}
    Login to jira
    Sleep      15s
    Wait Until Element Is Visible    xpath=//input[@name='projectName']    20s
    Input Text      name = projectName      ${VALID_PRJECT_EDIT_SUMMARY}
    Input Text      name = projectKey      ${VALID_PROJECT_EDIT_KEY}
    Click Button    xpath=//button[@type='submit'] 
    Sleep      15s
    Wait Until Page Contains       ${VALID_PRJECT_EDIT_SUMMARY}     20s
    [Teardown]    Close Browser

TC-FR7-02 Invalid edit of project details due to duplicate summary
    [Documentation]     verify the system shows error when the summary field is duplicate
    
    Open Browser       ${INVALID_PROJECT_EDIT_SETTING}      ${BROWSER}
    Login to jira
    Sleep      15s
    Wait Until Element Is Visible    xpath=//input[@name='projectName']    20s
    Input Text      name = projectName      Jira testing
    Input Text      name = projectKey      ${VALID_PROJECT_EDIT_KEY_2}
    Click Button    xpath=//button[@type='submit']
    Wait Until Page Contains       A project with that name already exists.       20s
    [Teardown]      Close Browser

TC-FR7-03 Invalid edit of project details due to duplicate key
    [Documentation]     verify the system shows error when the key field is duplicate
    
    Open Browser       ${INVALID_PROJECT_EDIT_SETTING}      ${BROWSER}
    Login to jira
    Sleep      15s
    Wait Until Element Is Visible    xpath=//input[@name='projectName']    20s
    Input Text      name = projectName      ${VALID_PRJECT_EDIT_SUMMARY_2}
    Input Text      name = projectKey      ${VALID_PROJECT_EDIT_KEY}
    Click Button    xpath=//button[@type='submit']
    Wait Until Page Contains       uses this project key.       20s
    [Teardown]      Close Browser

TC-FR7-04 add Project Members
    [Documentation]    verify that jira allows addition of members
    
    Open Browser       ${ACCESS_EDIT_LINK}      ${BROWSER}
    Login to jira
    Sleep      20s
    Wait Until Element Is Visible    xpath=//input[@id='invite-user-picker']    20s
    Sleep      10s
    Input Text      id = invite-user-picker     ${ADDED_USER}
    Sleep      7s
    Click Button    xpath=//button[@type='submit']
    Wait Until Page Contains       Added people to project       20s
    [Teardown]      Close Browser

TC-FR8-01 View of Project Dashboard
    [Documentation]     allow view of project Dashboard if teh project is created
    
    Open Browser       ${DASHBOARD}      ${BROWSER}
    Login to jira
    Wait Until Page Contains       Board       20s
    Wait Until Page Contains       Timeline       20s
    Wait Until Page Contains       List       20s  
    [Teardown]      Close Browser  






*** Keywords ***
Login to jira
    Wait Until Element Is Visible    xpath=//input[@name='username']    20s
    Input Text    xpath=//input[@name='username']    ${VALID EMAIL}
    Click Button    xpath=//button[@type='submit']
    Wait Until Element Is Visible    xpath=//input[@name='password']    20s
    Input Text    xpath=//input[@name='password']    ${VALID PASSWORD}
    Click Button    xpath=//button[@type='submit']