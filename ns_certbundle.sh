#!/bin/bash


echo "trying to check if certs exist"

cacert='/Library/Application Support/Netskope/STAgent/data/'nscacert.pem
tenantcert='/Library/Application Support/Netskope/STAgent/data/'nstenantcert.pem
certbundle='./'netskope-cert-bundle.pem
opensslbundle=/usr/local/etc/openssl/cert.pem
opensslbundlebak=/usr/local/etc/openssl/cert.pem.bak


if [ -f "$cacert" ] && [ -f "$tenantcert" ]
then
    echo "$cacert"
    echo "$tenantcert"
    
    if [ -f "$certbundle" ]
    then
       echo "Certificate bundle exists.Terminating processing ..." 
    else
       echo "Downlading Mozilla CA bundle"
       curl -L -o $certbundle https://curl.se/ca/cacert.pem
       echo -en "\nNetskope Tenant Certificate" >> "$certbundle"
       echo -en "\n###########################\n" >>"$certbundle"
       cat "$tenantcert" >> "$certbundle"
       echo -en "\nNetskope CA Certificate" >> "$certbundle"
       echo -en "\n###########################\n" >>"$certbundle"
       cat "$cacert" >> "$certbundle"
       if [ $? == 0 ]
       then  
           echo "Certificate bundle created"
       else
           echo "Error!!"
       fi
       if [ -f "$opensslbundle" ]
        then 
          cp $opensslbundle $opensslbundlebak
          cat "$tenantcert" "$cacert">> "$opensslbundle"
          echo "Added Netskope CA bundle to local OpenSSL CA in $opensslbundle"
        fi
    fi
else
    echo "Required certs not found. Please check if Netskope Client is installed"
fi
