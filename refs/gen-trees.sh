
pyang -p ../ -f tree --tree-line-length 71 --tree-print-groupings ../ietf-restconf-client\@*.yang > ietf-restconf-client-tree.txt
pyang -p ../ -f tree --tree-line-length 71 ../ietf-restconf-server\@*.yang > ietf-restconf-server-tree.txt

