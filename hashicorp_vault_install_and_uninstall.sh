mo066inflrun01 _diag # curl -I https://broker.actions.githubusercontent.com
HTTP/2 404
date: Wed, 23 Jul 2025 04:41:07 GMT
content-length: 12
content-type: text/plain; charset=utf-8
x-github-backend: Kubernetes
x-github-request-id: 8F38:3B32D3:1E3D51A:1F2B4CB:688067E3
server: github.com

mo066inflrun01 _diag # openssl s_client -connect broker.actions.githubusercontent.com:443
CONNECTED(00000003)
depth=3 C = US, ST = New Jersey, L = Jersey City, O = The USERTRUST Network, CN = USERTrust RSA Certification Authority
verify return:1
depth=2 C = GB, O = Sectigo Limited, CN = Sectigo Public Server Authentication Root R46
verify return:1
depth=1 C = GB, O = Sectigo Limited, CN = Sectigo Public Server Authentication CA DV R36
verify return:1
depth=0 CN = *.actions.githubusercontent.com
verify return:1
---
Certificate chain
 0 s:CN = *.actions.githubusercontent.com
   i:C = GB, O = Sectigo Limited, CN = Sectigo Public Server Authentication CA DV R36
   a:PKEY: rsaEncryption, 4096 (bit); sigalg: RSA-SHA384
   v:NotBefore: Jun 10 00:00:00 2025 GMT; NotAfter: Jun 10 23:59:59 2026 GMT
 1 s:C = GB, O = Sectigo Limited, CN = Sectigo Public Server Authentication CA DV R36
   i:C = GB, O = Sectigo Limited, CN = Sectigo Public Server Authentication Root R46
   a:PKEY: rsaEncryption, 3072 (bit); sigalg: RSA-SHA384
   v:NotBefore: Mar 22 00:00:00 2021 GMT; NotAfter: Mar 21 23:59:59 2036 GMT
 2 s:C = GB, O = Sectigo Limited, CN = Sectigo Public Server Authentication Root R46
   i:C = US, ST = New Jersey, L = Jersey City, O = The USERTRUST Network, CN = USERTrust RSA Certification Authority
   a:PKEY: rsaEncryption, 4096 (bit); sigalg: RSA-SHA384
   v:NotBefore: Mar 22 00:00:00 2021 GMT; NotAfter: Jan 18 23:59:59 2038 GMT
---
Server certificate
-----BEGIN CERTIFICATE-----
MIIHuDCCBiCgAwIBAgIQQpoM0ALJqV2GN3xNM4T2OjANBgkqhkiG9w0BAQwFADBg
MQswCQYDVQQGEwJHQjEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMTcwNQYDVQQD
Ey5TZWN0aWdvIFB1YmxpYyBTZXJ2ZXIgQXV0aGVudGljYXRpb24gQ0EgRFYgUjM2
MB4XDTI1MDYxMDAwMDAwMFoXDTI2MDYxMDIzNTk1OVowKjEoMCYGA1UEAwwfKi5h
Y3Rpb25zLmdpdGh1YnVzZXJjb250ZW50LmNvbTCCAiIwDQYJKoZIhvcNAQEBBQAD
ggIPADCCAgoCggIBANwvpdsZH4sqaZi93aUO0fMlanlA+9q37qP6fIK7jrhSen2r
YbJadNPyIc2j2B/iAs+MRBnxfpkNpCpwNZtWJA4LH3YhINRqD/Dt+Xixlkulc8Ga
er+4EcP1HjqH1pxxVfAMlOfFxFvAWWXA2B4W3PIzPN0r/cGE1RwNTx6PCnIAC06u
H1NOIGikEwZ11pxGVSc4Ah+LqfnRUfPdmAPONDbnEFyBzq83jKrNQujt/bgncsdt
ZjT3Mq4FGRHDRcsIsVet79wOG3yylFF9Vpnwk6Knzv4pTRnsx+Q2APXAMVIJk3Zn
s7jmDFmthyWqvL7Ox4lSw5Nf/cG8Dz5OyjKsmQKYGN3CXuBlOML4xyIN/hJ8I6N9
05swoOBFeSVEIhIaPRakW+TzMS7/G5vi42P+Qr/xQqkpX0bvLTRGq9/5utTA+G8k
lpKZoXv2wEdaiSVbU9IBRYusoNTCiOiagSXOj2FerI1AH2005UBpi9yfIBJpJXyw
/BTSPxuELjoa2YCNe4CB4NHJOUEeTScNJhLBdLljiP/909EbvGKDqxXvVCLZLeVe
qj1ONO41woCic5Esx7IeOeT8+/6U/B+yigBNg4EHOnafFDt6JCs7QCggziSR/I6b
EtRWsgkysYoi04Ch70820xfRfkoBD0a5ek84gy4cNL3fzJyWp+urwXkZcNcrAgMB
AAGjggMiMIIDHjAfBgNVHSMEGDAWgBRowBIWGA6vzvaHpjJXo0ZRXcsHJzAdBgNV
HQ4EFgQUNvfYmW3BgodYLPPz/xli4dQRV90wDgYDVR0PAQH/BAQDAgWgMAwGA1Ud
EwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMEkGA1UdIARC
MEAwNAYLKwYBBAGyMQECAgcwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdv
LmNvbS9DUFMwCAYGZ4EMAQIBMIGEBggrBgEFBQcBAQR4MHYwTwYIKwYBBQUHMAKG
Q2h0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1B1YmxpY1NlcnZlckF1dGhl
bnRpY2F0aW9uQ0FEVlIzNi5jcnQwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNl
Y3RpZ28uY29tMIIBgAYKKwYBBAHWeQIEAgSCAXAEggFsAWoAdwCWl2S/VViXrfdD
h2g3CEJ36fA61fak8zZuRqQ/D8qpxgAAAZdat61EAAAEAwBIMEYCIQCA65MwsKyq
FxSrXqhQR162ZRVldScjNerb+51MWqi4OQIhANk0Ah6wTitCDLqYwkX0KL0ccREH
fsEoXS+P+y9j1zCdAHcAGYbUxyiqb/66A294Kk0BkarOLXIxD67OXXBBLSVMx9QA
AAGXWretMAAABAMASDBGAiEAiTj7Lf7XXQo+NcR/gHZ0yMGH20jlJkVUXQYXlJWk
UjACIQCTfipxukvVKmCpD/rBnyM7OO5aNRZ+Dg0qMa9YHxvxCwB2AA5XlLzzrqk+
MxssmQez95Dfm8I9cTIl3SGpJaxhxU4hAAABl1q3rREAAAQDAEcwRQIgI7KUJeAI
kh36VrL7lW7QGYCNLm+yrSHFEe6SfV5TKsECIQCpndHbZIH0Y4TP9YXiUIWkTrUU
GaWlet40EwANT7SVKzBJBgNVHREEQjBAgh8qLmFjdGlvbnMuZ2l0aHVidXNlcmNv
bnRlbnQuY29tgh1hY3Rpb25zLmdpdGh1YnVzZXJjb250ZW50LmNvbTANBgkqhkiG
9w0BAQwFAAOCAYEAPCGSgvwRlgCuKBpSQ9YuuFvKsbMKIgLmVxu/grXpCgx8KdMr
+fld74WOmyZukk0PfrAm+gYZe+4dDKrzbn8inD6Wz2/UKiXRa9noZ5v0CL6qOy3b
RPZ8YgHYWrV0YEIqh5St+n1Dc0A1UhgTDFbHCQ/u1Lgw/dFasl6Iz8hnDTfQpoT5
05R6F3acsR/xKa74zrAWSFyCJo0BxE39KTW8sb71gv99ZFD5Nnj8D0nSdE7nU4af
IuF/ALfhH+n60VjaBfoeS9M/fQmEekxsZ5RFpmEMkDm3Y36tdDFKtFC9Cb4o9wal
FkZnwghK+JatRsjAj+5HmW7iKZoptAIK0Z3vKS/ptCql4wnDMDH7bkDsb9KeDEnN
6eG0PTNhnp+byRcFf+/KfVdNxsNw+sZqTly8bbg8Z2jnUd6o7XPEyIqVRm9KUjQk
f+Tb1cuwyT11MyCSxfFwHnCtgSh1wIPJRvbcFlL4K9HJYvG1UuXHLsRQB6/KG0oK
WgluOHrqp6q8psLk
-----END CERTIFICATE-----
subject=CN = *.actions.githubusercontent.com
issuer=C = GB, O = Sectigo Limited, CN = Sectigo Public Server Authentication CA DV R36
---
No client certificate CA names sent
Peer signing digest: SHA256
Peer signature type: RSA-PSS
Server Temp Key: X25519, 253 bits
---
SSL handshake has read 6095 bytes and written 402 bytes
Verification: OK
---
New, TLSv1.3, Cipher is TLS_AES_128_GCM_SHA256
Server public key is 4096 bit
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
Early data was not sent
Verify return code: 0 (ok)
---
---
Post-Handshake New Session Ticket arrived:
SSL-Session:
    Protocol  : TLSv1.3
    Cipher    : TLS_AES_128_GCM_SHA256
    Session-ID: 61DAFD1083B3BE5D3841584011FE454595F73EB9D27FE2E8EBD930ED88724479
    Session-ID-ctx:
    Resumption PSK: 8140E256B468DA5B4EA308E6327FA57957E43ECA0A523DB5AA70A9DC56618C45
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 7200 (seconds)
    TLS session ticket:
    0000 - 41 ab f8 45 82 ff f7 d9-28 95 4c 04 33 c0 0e f3   A..E....(.L.3...
    0010 - eb 16 7e 4f 94 5b 7d 85-c5 87 9d 8e b2 9d f9 90   ..~O.[}.........

    Start Time: 1753245727
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: no
    Max Early Data: 0
---
read R BLOCK
---
Post-Handshake New Session Ticket arrived:
SSL-Session:
    Protocol  : TLSv1.3
    Cipher    : TLS_AES_128_GCM_SHA256
    Session-ID: E05444ABCD7050B9DA24AD0A003CECF764E6C5FCA75A3DBFD0B849BEDE85748E
    Session-ID-ctx:
    Resumption PSK: 3BCCEE35C1DF9954C6D9CA9680470F0632895E752291E5D14269AAD732A98BBE
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 7200 (seconds)
    TLS session ticket:
    0000 - cc 04 24 f1 d4 47 e3 27-86 e4 75 8a e6 d5 f5 5f   ..$..G.'..u...._
    0010 - dd 67 2a f5 fe 8c c5 89-06 92 85 85 cc ac 82 57   .g*............W

    Start Time: 1753245727
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: no
    Max Early Data: 0
---
read R BLOCK
closed
