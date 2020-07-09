echo "Generating tree diagrams..."

pyang -p ../ -f tree --tree-line-length 69 --tree-no-expand-uses ../ietf-restconf-client\@*.yang > ietf-restconf-client-tree-no-expand.txt
pyang -p ../ -f tree --tree-line-length 69 --tree-no-expand-uses ../ietf-restconf-server\@*.yang > ietf-restconf-server-tree-no-expand.txt 

#pyang -p ../ -f tree --tree-line-length 69 ../ietf-restconf-client\@*.yang > ietf-restconf-client-tree.txt
#pyang -p ../ -f tree --tree-line-length 69 ../ietf-restconf-server\@*.yang > ietf-restconf-server-tree.txt

extract_grouping_with_params() {
  # $1 name of module
  # $2 name of grouping
  # $3 addition CLI params
  # $4 output filename
  pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings $3 ../$1@*.yang | gsed -e 's/grouping restconf-client-grouping/grouping restconf-client-grouping ---> <empty>/' -e '/^ *+-- restconf-client-parameters/a\                +---u rcc:restconf-client-grouping' -e '/|     +-- restconf-client-parameters/a\       |        +---u rcc:restconf-client-grouping' > $1-groupings-tree.txt
  cat $1-groupings-tree.txt | sed -n "/^  grouping $2/,/^  grouping/p" > tmp
  c=$(grep -c "^  grouping" tmp)
  if [ "$c" -ne "1" ]; then
    ghead -n -1 tmp > $4
    rm tmp
  else
    mv tmp $4
  fi
}

extract_grouping() {
  # $1 name of module
  # $2 name of groupin
  #extract_grouping_with_params "$1" "$2" "" "tree-$2.expanded.txt"
  extract_grouping_with_params "$1" "$2" "--tree-no-expand-uses" "tree-$2.no-expand.txt"
}

extract_grouping ietf-restconf-client restconf-client-grouping
extract_grouping ietf-restconf-client restconf-client-initiate-stack-grouping
extract_grouping ietf-restconf-client restconf-client-listen-stack-grouping
extract_grouping ietf-restconf-client restconf-client-app-grouping

extract_grouping ietf-restconf-server restconf-server-grouping
extract_grouping ietf-restconf-server restconf-server-listen-stack-grouping
extract_grouping ietf-restconf-server restconf-server-callhome-stack-grouping
extract_grouping ietf-restconf-server restconf-server-app-grouping

