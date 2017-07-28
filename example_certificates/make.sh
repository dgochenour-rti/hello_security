export OPENSSL_EXE=openssl
export OPENSSL_CONF=./input/openssl.cnf
rm *.xml
rm *.csr
rm *.pem
rm demoCA/*
rm demoCA/private/*
rm -rf ./output

mkdir output && \
mkdir -p 'demoCA' && \
mkdir -p 'demoCA/private' && \
$OPENSSL_EXE genrsa -out demoCA/private/cakey.pem 2048 && \
$OPENSSL_EXE req -new -key demoCA/private/cakey.pem -out ca.csr -config input/openssl.cnf && \
$OPENSSL_EXE x509 -req -days 3650 -in ca.csr -signkey demoCA/private/cakey.pem -out demoCA/cacert.pem && \
mkdir -p 'demoCA/newcerts' && \
touch demoCA/index.txt && \
echo 01 > demoCA/serial && \
# Generate private key for CA
$OPENSSL_EXE genrsa -out HelloSecurePublisher_key.pem 2048 && \
# Create Certificate request
$OPENSSL_EXE req -config input/HelloSecurePublisher.cnf -new -key HelloSecurePublisher_key.pem -out temp.csr && \
# Sign Certificate request for Domain Participant by CA
$OPENSSL_EXE ca -days 365 -in temp.csr -out HelloSecurePublisher_cert.pem && \
# Create Permissions Grant File for Domain Participant
# Sign Permissions Document
$OPENSSL_EXE smime -sign -in input/HelloSecurePublisher_permissions.xml -text -out signed_HelloSecurePublisher_permissions.xml -signer demoCA/cacert.pem -inkey demoCA/private/cakey.pem && \
#generate private key for CA
$OPENSSL_EXE genrsa -out HelloSecureSubscriber_key.pem 2048 && \
# Create Certificate request
$OPENSSL_EXE req -config input/HelloSecureSubscriber.cnf -new -key HelloSecureSubscriber_key.pem -out temp.csr && \
# Sign Certificate request for Domain Participant by CA
$OPENSSL_EXE ca -days 365 -in temp.csr -out HelloSecureSubscriber_cert.pem && \
# Create Permissions Grant File for Domain Participant
# Sign Permissions Document
$OPENSSL_EXE smime -sign -in input/HelloSecureSubscriber_permissions.xml -text -out signed_HelloSecureSubscriber_permissions.xml -signer demoCA/cacert.pem -inkey demoCA/private/cakey.pem && \
# Sign governance file
$OPENSSL_EXE smime -sign -in input/Governance.xml -text -out signed_Governance.xml -signer demoCA/cacert.pem -inkey demoCA/private/cakey.pem && \

if [ $? -eq 0 ]; then
    echo "Done."
else
    echo "Something went wrong..."
    exit -1
fi

cp signed*.xml output/ && cp HelloSecure*.pem output/ && cp demoCA/cacert.pem output/

echo "Done. Check the output folder."
