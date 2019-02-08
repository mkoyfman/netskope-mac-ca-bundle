#!/bin/bash


echo "trying to check if certs exist"

cacert='/Library/Application Support/Netskope/STAgent/data/'nscacert.pem
tenantcert='/Library/Application Support/Netskope/STAgent/data/'nstenantcert.pem
certbundle='./'netskope-cert-bundle.pem


if [ -f "$cacert" ] && [ -f "$tenantcert" ]
then
    echo "$cacert"
    echo "$tenantcert"
    
    if [ -f "$certbundle" ]
    then
       echo "Certificate bundle exists.Terminating processing ..." 
    else
       echo "Downlading Mozilla CA bundle"
       curl -o $certbundle https://curl.haxx.se/ca/cacert.pem
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
    fi
else
    echo "Required certs not found. Please check if Netskope Client is installed"
fi
