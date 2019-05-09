echo "Testing ietf-restconf-client\@*.yang (pyang)..."
pyang --ietf --max-line-length=69 -p ../ ../ietf-restconf-client\@*.yang

echo "Testing ietf-restconf-server\@*.yang (pyang)..."
pyang --ietf --max-line-length=69 -p ../ ../ietf-restconf-server\@*.yang

echo "Testing ietf-restconf-client\@*.yang (yanglint)..."
yanglint -p ../ ../ietf-restconf-client\@*.yang

echo "Testing ietf-restconf-server\@*.yang (yanglint)..."
yanglint -p ../ ../ietf-restconf-server\@*.yang

echo "Testing ex-restconf-client.xml..."
yanglint -m -s ../ietf-*\@*.yang ietf-origin.yang ex-restconf-client.xml ../../trust-anchors/refs/ex-truststore.xml ../../keystore/refs/ex-keystore.xml

echo "Testing ex-restconf-server.xml..."
yanglint -m -s ../ietf-*\@*.yang ietf-origin.yang ietf-x509-cert-to-name@2014-12-10.yang ex-restconf-server.xml ../../trust-anchors/refs/ex-truststore.xml ../../keystore/refs/ex-keystore.xml
