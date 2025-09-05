*** Settings ***
Library           AppiumLibrary

Suite Setup    Open Application    ${REMOTE_URL}       # Dessa forma o processo de abertura do site vai ocorer somente uma vez durante a execução dos 6 testes.
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
    ...    unhandledPromptBehavior=ignore
    # Fim da configuração do emulador/aprelho fisico e da inicialização.

Test Teardown    limpar Carrinho e Deslogar        # Ocorre apos a execução de todos os testes
Suite Teardown    Close Application                # Ocorre a pos a execução de todos os testes

Test Template    Selecionar Produto

*** Variables ***        # A url abaixo foi buscada no site do "saucelabes.com"
${SAUCE_USERNAME}   Spoock        # Essa variavel foi adapitada na url original. 
${SAUCE_ACCESS_KEY}    0d7d6c1f-eb42-4a8e-bfdb-9a3d49185110    # Esse item pode ser protegido do uso por outros usuários, arquivadoo dentro da variavel %{SAUCE_ACCCES_KEY}, porem só funciona quando executado pelo terminal (prompt).
${REMOTE_URL}    https://${SAUCE_USERNAME}:${SAUCE_ACCESS_KEY}@ondemand.us-west-1.saucelabs.com:443/wd/hub
*** Test Cases ***
TC001    Sauce Labs Backpack    $ 29.99    0            # 0 não rolar a tela
TC002    Sauce Labs Bike Light    $ 9.99    0
TC003    Sauce Labs Bolt T-Shirt    $ 15.99    0
TC004    Sauce labs Fleece Jacket    $ 49.99    0
TC005    Sauce labs Onesie    $ 7.99    1           # 1 rola a tela
TC006    Test.sllTheThings() T-Shirt   $ 15.99    1

*** Keywords ***   # O test nao funciona porque ele esta abrindo direto na pagina da muchila e não na pagina de produtos. Precisa abrir numa pagina antes!
Selecionar Produto
    [Arguments]    ${Product_Name}    ${Product_Price}    ${swipe_count}
    #${img_produto} =    Set Variable     xpath=(//android.widget.ImageView[@content-desc="Product Image"])[1]
    ${img_produto} =    Set Variable     xpath=//android.widget.TextView[@text="${Product_Name}"]/../android.widget.ImageView    # Indicação da IA.
    FOR    ${counter}    IN RANGE    ${swipe_count}            # Comando de rolagem da pagina para produtos que estão na parte de baixo.
        Swipe By Percent    50    80    50    20
    END
    Click Element    ${img_produto}

    Swipe By Percent    50    80    50    20
    
    ${btn_adicionar_carrinho} =    Set Variable     xpath=//android.widget.Button[@content-desc="Tap to add product to cart"]
    Wait Until Element Is Visible    ${btn_adicionar_carrinho}
    Click Element    ${btn_adicionar_carrinho}

    ${ico_carrinho} =    Set Variable     id=com.saucelabs.mydemoapp.android:id/cartIV
    Wait Until Element Is Visible    ${ico_carrinho}    #timeout=10s
    Click Element    ${ico_carrinho}

    ${lbl_nome_produto} =    Set Variable     xpath=//android.widget.TextView[@resource-id="com.saucelabs.mydemoapp.android:id/titleTV"]
    Wait Until Element Is Visible    ${lbl_nome_produto}    #timeout=10s
    Element Text Should Be    ${lbl_nome_produto}    ${Product_Name}

    ${lbl_preco_produto} =    Set Variable     id=com.saucelabs.mydemoapp.android:id/priceTV
    Wait Until Element Is Visible    ${lbl_preco_produto}    #timeout=10s
    Element Text Should Be    ${lbl_preco_produto}    ${Product_Price}
limpar Carrinho e Deslogar        # Esse item foi elaborado como padrão diretamente pelo professor.
    Wait Until Element Is Visible    id=com.saucelabs.mydemoapp.android:id/removeBt    #timeout=10s
    Click Element    id=com.saucelabs.mydemoapp.android:id/removeBt        # Comando meio que padrão
    # Abre menu humburger
    Wait Until Element Is Visible    id=com.saucelabs.mydemoapp.android:id/menuIV    #timeout=10s
    Click Element    id=com.saucelabs.mydemoapp.android:id/menuIV        # padrão para click no menu hamburger
    # Clica em Logout
    ${btn_logout} =    Set Variable    xpath=//androidx.recyclerview.widget.RecyclerView[@content-desc="Recycler view for menu"]/android.view.ViewGroup[1]/android.widget.TextView[2]
    Wait Until Element Is Visible    ${btn_logout}    #timeout=10s
    Click Element    ${btn_logout}
