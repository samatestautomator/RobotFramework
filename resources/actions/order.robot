*** Settings ***
Documentation    Ações da funcionalidade de fechamento de pedido

Library    Browser

*** Keywords ***
Go Checkout
    Click    text=Fechar Pedido

    ${element}    Set Variable    css=.page-header    

    Wait For Elements State    ${element}      visible     10
    Get Text                   ${element}      contains    Finalize o seu pedido

Fill Data Customer
    [Arguments]    ${customer}

    Fill Text    css=input[placeholder="Nome"]            ${customer["name"]}
    Fill Text    css=input[placeholder="E-mail"]          ${customer["email"]}
    Fill Text    css=input[placeholder^="Confirmação"]    ${customer["email"]}
    Fill Text    css=input[placeholder="Endereço"]        ${customer["addres"]}
    Fill Text    css=input[placeholder="Número"]          ${customer["number"]}


Select payment Option
    [Arguments]        ${payment}
    
    IF        "${payment}" == "Dinheiro"
        
        Click        xpath=(//mt-radio//label)[1]//div

    ELSE IF    "${payment}" == "Cartão de Débito"

        Click        xpath=(//mt-radio//label)[2]//div
    
    ELSE IF    "${payment}" == "Cartão de Refeição"  
        
        Click        xpath=(//mt-radio//label)[3]//div

    ELSE 

        Fail   Incorrect payment type
    
    END



Pay order    
    Click    text=Concluir pedido


Order Should Be Completed
    Wait For Elements State    css=p >> text=Seu pedido foi recebido pelo restaurante.    visible    10




    



