# netskope-mac-ca-bundle
Generate custom CA bundle augmented with Netskope CA certificates

This script downloads Mozilla's latest CA bundle and augments it with your Netskope tenant's CA and Netskope root CA for use with various tools and CLI frameworks on Mac that do not leverage OS X system keychain for CA bundle/certificates.

The script creates file called netskope-cert-bundle.pem that can be referenced by your CLI tools such as AWS CLI, Azure CLI, etc.

Testing VSTS
