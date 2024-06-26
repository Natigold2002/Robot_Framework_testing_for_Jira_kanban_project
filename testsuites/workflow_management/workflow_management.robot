*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${VALID_EMAIL}    natnael.workuk@aastustudent.edu.et
${VALID_PASSWORD}    Password@02
${BROWSER}      chrome
${WORKFLOW_BOARD}      https://svvttestingproject.atlassian.net/jira/software/projects/KAN/settings/issuetypes/10001/workflow
${VALID_NEW_STATE}      TESTING
${ISSUE_LINK}       https://svvttestingproject.atlassian.net/jira/software/projects/KAN/boards/1?selectedIssue=KAN-2


*** Test Cases ***
TC-FR9-01 valid creation of workflow state
    [Documentation]     verify if the system allows valid creation of workflow state
    Open Browser        ${WORKFLOW_BOARD}      ${BROWSER}
    Login to jira
    Sleep   20s
    Wait Until Element Is Visible    xpath=//input[@id='workflow-editor.status-dialog.status-creator.input']    20s
    Input Text      id = workflow-editor.status-dialog.status-creator.input     ${VALID_NEW_STATE}
    Sleep      10s
    Click Button       xpath=//button[@data-testid='workflow-editor.status-dialog.submit-button']
    Wait Until Element Is Visible    xpath=//button[@id='workflow-editor.toolbar.save-and-close']    20s
    Click Button        xpath=//button[@id='workflow-editor.toolbar.save-and-close']
    Wait Until Element Is Visible    xpath=//div[@data-testid='workflow-associate.ui.associate-workflow-with-issue-types-modal--footer']    20s
    Click Button        xpath=//div[@data-testid='workflow-associate.ui.associate-workflow-with-issue-types-modal--footer']//button[1]
    Wait Until Page Contains        It may take some time to update the issue affected by your recent changes.      20s
    [Teardown]      Close Browser

TC-FR9-02 invalid creation of state due to duplicate state name
    [Documentation]     verify if the system shows error message when duplicate state name is used to create state
    Open Browser        ${WORKFLOW_BOARD}      ${BROWSER}
    Login to jira
    Sleep   15s
    Wait Until Element Is Visible    xpath=//input[@id='workflow-editor.status-dialog.status-creator.input']    20s
    Input Text      id = workflow-editor.status-dialog.status-creator.input     DONE
    Sleep      10s
    Click Button       xpath=//button[@data-testid='workflow-editor.status-dialog.submit-button'] 
    Wait Until Page Contains       Already exists. Try a different name.        20s
    [Teardown]      Close Browser   
TC-FR9-03 invalid creation of state due to Missing name
    [Documentation]     verify that the system does not allow creation of state with empty name
    Open Browser        ${WORKFLOW_BOARD}      ${BROWSER}
    Login To Jira
    Sleep               15s
    Wait Until Element Is Visible    xpath=//input[@id='workflow-editor.status-dialog.status-creator.input']    20s
    Element Should Be Disabled       xpath=//button[@data-testid='workflow-editor.status-dialog.submit-button']
    [Teardown]      Close Browser

TC-FR9-04 valid creation of transition between states
    [Documentation]     verify that the systems allow creation of transition between states
    Open Browser        ${WORKFLOW_BOARD}      ${BROWSER}
    Login To Jira
    Sleep               15s
    Wait Until Element Is Visible      xpath=//input[contains(@id, 'project-config-commons-status-multi-selector')]     20s
    Input Text       xpath=//input[contains(@id, 'project-config-commons-status-multi-selector')]      TO DO
    Sleep       5s
    Input Text        xpath=//input[contains(@id, 'project-config-commons-status-selector')]      DONE
    Sleep       5s
    Input Text        xpath=//input[contains(@id, 'transition-name')]      transition_new
    Click Button        xpath=//button[@data-testid = 'workflow-editor.transition-dialog.submit']

    Wait Until Element Is Visible    xpath=//button[@id='workflow-editor.toolbar.save-and-close']    20s
    Click Button        xpath=//button[@id='workflow-editor.toolbar.save-and-close']
    Sleep       10s
    Wait Until Element Is Visible    xpath=//div[@data-testid='workflow-associate.ui.associate-workflow-with-issue-types-modal--footer']    20s
    Sleep       10s
    Click Button        xpath=//div[@data-testid='workflow-associate.ui.associate-workflow-with-issue-types-modal--footer']//button[1]
    Wait Until Page Contains        It may take some time to update the issue affected by your recent changes.      20s
    [Teardown]      Close Browser

TC-FR9-05 invalid transition creation due to Missing from state
    [Documentation]     verify that it does not allow creation of transition when the from stateis not specified
    Open Browser        ${WORKFLOW_BOARD}      ${BROWSER}
    Login To Jira
    Sleep               15s
    Wait Until Element Is Visible      xpath=//input[contains(@id, 'project-config-commons-status-multi-selector')]     20s
    Input Text        xpath=//input[contains(@id, 'project-config-commons-status-selector')]      TO DO
    Sleep       5s
    Input Text        xpath=//input[contains(@id, 'transition-name')]      transition_new_2
    Element Should Be Disabled       xpath=//button[@data-testid='workflow-editor.transition-dialog.submit']
    [Teardown]      close Browser

TC-FR9-06 invalid transition creation due to Missing to state
    [Documentation]     verify that it does not allow creation of transition when the to stateis not specified
    Open Browser        ${WORKFLOW_BOARD}      ${BROWSER}
    Login To Jira
    Sleep               15s
    Wait Until Element Is Visible      xpath=//input[contains(@id, 'project-config-commons-status-multi-selector')]     20s
    Input Text       xpath=//input[contains(@id, 'project-config-commons-status-multi-selector')]      TO DO
    Sleep       5s
    Input Text        xpath=//input[contains(@id, 'transition-name')]      transition_new_2
    Element Should Be Disabled       xpath=//button[@data-testid='workflow-editor.transition-dialog.submit']
    [Teardown]      close Browser

TC-FR9-07 invalid transition creation due to Missing transition name
    [Documentation]     verify that it does not allow creation of transition when the transition name is not specified
    Open Browser        ${WORKFLOW_BOARD}      ${BROWSER}
    Login To Jira
    Sleep               15s
    Wait Until Element Is Visible      xpath=//input[contains(@id, 'project-config-commons-status-multi-selector')]     20s
    Input Text       xpath=//input[contains(@id, 'project-config-commons-status-multi-selector')]      TO DO
    Sleep       5s
    Input Text        xpath=//input[contains(@id, 'project-config-commons-status-selector')]      DFGH
    Sleep       5s
    Element Should Be Disabled       xpath=//button[@data-testid='workflow-editor.transition-dialog.submit']
    [Teardown]      close Browser

TC-FR10-01 valid issue transition from one state to another
    [Documentation]     verify that it does  allow  transition of state from one to another
    Open Browser       ${ISSUE_LINK}        ${BROWSER}
    Login to jira
    Sleep       10s
    Wait Until Element Is Visible   xpath=//button[@id = 'issue.fields.status-view.status-button']
    Click Button    xpath=//button[@id = 'issue.fields.status-view.status-button']
    Sleep       15s
    Element Should Be Visible    xpath=//div[@data-testid='platform-board-kit.ui.column.draggable-column.styled-wrapper'][4]//div[@data-testid='software-board.board-container.board.card-container.card-with-icc']
    [Teardown]      Close Browser






*** Keywords ***
Login to jira
    Wait Until Element Is Visible    xpath=//input[@name='username']    20s
    Input Text    xpath=//input[@name='username']    ${VALID EMAIL}
    Click Button    xpath=//button[@type='submit']
    Wait Until Element Is Visible    xpath=//input[@name='password']    20s
    Input Text    xpath=//input[@name='password']    ${VALID PASSWORD}
    Click Button    xpath=//button[@type='submit']