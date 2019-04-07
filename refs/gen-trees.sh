
pyang -p ../ -f tree --tree-line-length 69 ../ietf-restconf-client\@*.yang > ietf-restconf-client-tree.txt
pyang -p ../ -f tree --tree-line-length 69 ../ietf-restconf-server\@*.yang > ietf-restconf-server-tree.txt

pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings --tree-no-expand-uses ../ietf-restconf-client\@*.yang > ietf-restconf-client-tree-no-expand.txt
pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings --tree-no-expand-uses ../ietf-restconf-server\@*.yang > ietf-restconf-server-tree-no-expand.txt

