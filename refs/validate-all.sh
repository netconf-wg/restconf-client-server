
echo "Testing YANG syntax..."
pyang --ietf --max-line-length=70 -p ../ ../ietf-restconf-client\@*.yang
pyang --ietf --max-line-length=70 -p ../ ../ietf-restconf-server\@*.yang

yanglint -p ../ ../ietf-restconf-client\@*.yang
yanglint -p ../ ../ietf-restconf-server\@*.yang


echo "Testing ex-restconf-client.xml..."
yanglint -m -p ../ -s ../ietf-restconf-client\@*.yang ex-restconf-client.xml ../../keystore/refs/ex-keystore.xml

echo "Testing ex-restconf-server.xml..."
yanglint -m -p ../ -s ../ietf-restconf-server\@*.yang ietf-x509-cert-to-name@2014-12-10.yang ex-restconf-server.xml ../../keystore/refs/ex-keystore.xml


