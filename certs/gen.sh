#!/bin/bash
 certtool  \
    --generate-privkey  \
    --outfile /opt/certs/ca-key.pem && \ 
 certtool  \
    --generate-self-signed  \
    --load-privkey /opt/certs/ca-key.pem  \
    --template /opt/certs/ca-tmp  \
    --outfile /opt/certs/ca-cert.pem && \ 
 certtool  \
    --generate-privkey  \
    --outfile /opt/certs/server-key.pem && \ 
 certtool  \
    --generate-certificate  \
    --load-privkey /opt/certs/server-key.pem  \
    --load-ca-certificate /opt/certs/ca-cert.pem  \
    --load-ca-privkey /opt/certs/ca-key.pem  \
    --template /opt/certs/serv-tmp  \
    --outfile /opt/certs/server-cert.pem && \ 
 certtool  \
    --generate-privkey  \
    --outfile /opt/certs/user-key.pem && \ 
 certtool  \
    --generate-certificate  \
    --load-privkey /opt/certs/user-key.pem  \
    --load-ca-certificate /opt/certs/ca-cert.pem  \
    --load-ca-privkey /opt/certs/ca-key.pem  \
    --template /opt/certs/user-tmp  \
    --outfile /opt/certs/user-cert.pem 

