## Requirement 
1. Mikrotik device upgraded to 7+ rc version

## Install Self Signed Certificate
/certificate
add name=ca-template days-valid=3650 common-name=your.server.url key-usage=key-cert-sign,crl-sign
add name=server-template days-valid=3650 common-name=your.server.url

/certificate
sign ca-template name=root-ca
:delay 3s
sign ca=root-ca server-template name=server
:delay 3s

/certificate
set root-ca trusted=yes
set server trusted=yes

/ip service
set www-ssl certificate=server disabled=no

## Test via postman
https://192.168.88.1/rest/ip/hotspot/user/ramel

curl --location --request GET 'https://192.168.88.1/rest/ip/hotspot/user' \
--header 'Authorization: Basic <BasicAuthToken>' \

### How to generate <BasicAuthToken>
visit https://www.base64encode.org/

### Encode
```js 
  username:password




