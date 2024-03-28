# HMAC Generator

Simple bash/zsh script that calculates the Base64 HMAC for the given input string, algorithm and secret.

Example usage:
```
export HMAC_INPUT="date: Thu, 22 Jun 2017 17:15:21 GMT\nGET /requests HTTP/1.1"

./hmac-generator.sh -a sha256 -s secret $HMAC_INPUT
```

This will generate the Base64 SHA256 HMAC for the input message:
```
date: Thu, 22 Jun 2017 17:15:21 GMT
GET /requests HTTP/1.1
```
.... and the secret `secret`.


Output can be compared with the online HMAC generator that can be found here: https://dinochiesa.github.io/hmachash/index.html