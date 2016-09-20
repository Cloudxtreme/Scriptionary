#!/bin/bash

echo "Easily generate RSA keys with a few basic options."
echo "--------------------------------------------------------------"
echo "Warning, the password option is not safe on a shared machine."
echo "As stated in the openssl man page, your password will be"
echo "visible durring key generation using the ps command."
echo ""

echo -n "Key name (none): "
read name

echo -n "Key bit length (2048): "
read bits
if [ "$bits" == "" ]; then
    bits=2048
fi

echo -n "Key password: (leave blank for none):"
read password 

opts_priv=""
opts_pub=""

if [ "$password" != "" ]; then
    opts_priv="$opts_priv -des3 -passout pass:$password"
    opts_pub="$opts_pub -passin pass:$password"
fi

pub=$name"public.pem"
priv=$name"private.pem"

openssl genrsa $opts_priv -out $priv $bits
openssl rsa $opts_pub -in $priv -outform PEM -pubout -out $pub
