# As informações abaixo, vieram com o import do script copiado do Appium Inspector:

# This sample code supports Appium Robot client >=2
# pip install robotframework-appiumlibrary
# Then you can paste this into a file and simply run with Robot
#
# Find keywords at: http://serhatbolsu.github.io/robotframework-appiumlibrary/AppiumLibrary.html
#
# If your tests fails saying 'did not match any elements' consider using 'wait activity' or
# 'wait until page contains element' before a click command

*** Settings ***
Library           AppiumLibrary
Test Teardown    Close Application        # Apaga e limpa a memoria apos a execução do teste.

*** Variables ***        # A url abaixo foi buscada no site do "saucelabes.com"
${SAUCE_USERNAME}   Spoock        # Essa variavel foi adapitada na url original. 
${SAUCE_ACCESS_KEY}    0d7d6c1f-eb42-4a8e-bfdb-9a3d49185110    # Esse item pode ser protegido do uso por outros usuários, arquivadoo dentro da variavel %{SAUCE_ACCCES_KEY}, porem só funciona quando executado pelo terminal (prompt).
${REMOTE_URL}    https://${SAUCE_USERNAME}:${SAUCE_ACCESS_KEY}@ondemand.us-west-1.saucelabs.com:443/wd/hub

*** Test Cases ***
Selecionar Mochila
    Open Application    ${REMOTE_URL}
    ...    platformName=Android
    ...    appium:platformVersion=9.0
    ...    appium:deviceName=Galaxy S9 FHD GoogleAPI Emulator
    ...    appium:deviceOrientation=portrait
    ...    appium:app=storage:filename=mda-2.2.0-25.apk
    ...    appium:appPackage=com.saucelabs.mydemoapp.android
    ...    appium:appActivity=com.saucelabs.mydemoapp.android.view.activities.SplashActivity
    ...    browserName=
    ...    appium:ensureWebviewsHavePages=${True}
    ...    appium:nativeWebScreenshot=${True}
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    #...    webSocketUrl=${True}            # Foi excluido pois não é necessário.
    #...    unhandledPromptBehavior=ignore
    # Fim da configuração do emulador/aprelho fisico e da inicialização

    # Inicio dos passos da automação:
    ${img_produto} =    Set Variable     xpath=(//android.widget.ImageView[@content-desc="Product Image"])[1]
    Click Element    ${img_produto}
    Swipe By Percent    50    80    50    20
    #Swipe    560    1851    572    1534                # Versão antiga não mais utilizada (Substituida pela linha 43)
    ${btn_adicionar_carrinho} =    Set Variable     xpath=//android.widget.Button[@content-desc="Tap to add product to cart"]
    Wait Until Element Is Visible    ${btn_adicionar_carrinho}
    Click Element    ${btn_adicionar_carrinho}
    ${ico_carrinho} =    Set Variable     id=com.saucelabs.mydemoapp.android:id/cartIV
    Click Element    ${ico_carrinho}
    ${lbl_nome_produto} =    Set Variable     xpath=//android.widget.TextView[@resource-id="com.saucelabs.mydemoapp.android:id/titleTV"]
    Element Text Should Be    ${lbl_nome_produto}    Sauce Labs Backpack
    #Element Should Contain Text    ${lbl_nome_produto}    Sauce Labs Backpack (orange)    # Poderia utilizar essa linha em substituição a linha 50.
    ${lbl_preco_produto} =    Set Variable     id=com.saucelabs.mydemoapp.android:id/priceTV
    Element Text Should Be    ${lbl_preco_produto}    $ 29.99
