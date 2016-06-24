
pyang -p ../ -f tree ../ietf-restconf-client\@*.yang > ietf-restconf-client-tree.txt.tmp
pyang -p ../ -f tree ../ietf-restconf-server\@*.yang > ietf-restconf-server-tree.txt.tmp

fold -w 71 ietf-restconf-client-tree.txt.tmp > ietf-restconf-client-tree.txt
fold -w 71 ietf-restconf-server-tree.txt.tmp > ietf-restconf-server-tree.txt

rm *-tree.txt.tmp
