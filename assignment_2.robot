*** Variables ***
${HOST}     https://www.amazon.com/
${BROWSER}   Chrome
${item not found}   Item Not Found
${item found}      Item Found

*** Settings ***
Documentation    Suite description
Library           SeleniumLibrary
Library           Collections
Library           String
Library           DateTime

Test Setup     Open Browser To Login Page
Test Teardown  Close Browser

*** Test Cases ***
Test title
    Search The Given Item  Nikon
    Sort Items in Arranged Manner   Nikon
    Click Specified Item for Details   1   Nikon D3X

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${HOST}    ${BROWSER}

Search The Given Item
    [Arguments]  ${item}
    Wait Until Page Contains Element   //input[@id="twotabsearchtextbox"]
    Input Text    //input[@id="twotabsearchtextbox"]    ${item}
    Click Element   //input[@type="submit"]
    Page Should Contain   ${item}

Sort Items in Arranged Manner
    [Arguments]  ${item}
    Wait Until Page Contains Element    //span[contains(@aria-label,'Sort by:')]
    Click Element      //span[contains(@aria-label,'Sort by:')]
    Wait Until Page Contains Element    //a[contains(text(), 'Price: High to Low')]
    Click Element    //a[contains(text(), 'Price: High to Low')]
    Page Should Contain   ${item}

Click Specified Item for Details
    [Arguments]  ${num}  ${item}
    Click Element   //div[contains(@data-index,${num})]//a
    ${present}  Run Keyword And Return Status    Page Should Contain   ${item}
    Run Keyword If    ${present}
    ...  Log   ${item found}
    ...  ELSE
    ...  Log   ${item not found}
