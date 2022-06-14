# Backend para envio de email do novo site CED

Configurações necessárias:

1- Antes de utilizar API será necessário fazer as configurações no arquivo appsettings.json. 

Exemplo:
 ```
 "MailSettings": {
    "fromEmail": "cedteste.api@gmail.com", // Coloque o email do remetente aqui
    "ToMail": "cedteste.api@gmail.com", // Coloque o email do destinatario aqui
    "DisplayName": "CED",
    "Password": "CED@291128", // Coloque a senha do email aqui
    "Host": "smtp.gmail.com",
    "Port": 587
  }
  ```

## Ambientes

### Desenvolvimento

https://cld1.trescon.com.br/CED_dev/api/  
[![Build Status](http://192.168.1.64:8999/api/badges/CED/back/status.svg?ref=refs/heads/dev)](http://192.168.1.64:8999/CED/back)  

### testes/QA

https://cld1.trescon.com.br/CED_qa/api/  
[![Build Status](http://192.168.1.64:8999/api/badges/CED/back/status.svg?ref=refs/heads/qa)](http://192.168.1.64:8999/CED/back)  

### Homologação

https://cld1.trescon.com.br/CED_hml/api/ 
[![Build Status](http://192.168.1.64:8999/api/badges/CED/back/status.svg?ref=refs/heads/hml)](http://192.168.1.64:8999/CED/back)  

### Produção

A ser definido pela CED/B3
