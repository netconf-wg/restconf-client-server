#!/bin/bash

#FOLD=fold-artwork.sh
FOLD=../../netmod-wg/artwork-folding/fold-artwork.sh

# make sure input params are good
if [ "$#" == "0" ]; then
  echo "Usage: $0 file[,fold-length]"
  exit
fi

cp $1 .tmp.new.txt
while ( grep INSERT_TEXT_FROM_FILE .tmp.new.txt >> /dev/null ); do
  i=`grep -n INSERT_TEXT_FROM_FILE .tmp.new.txt | head -1`
  linenum=`echo $i | sed 's/:.*//'`
  file=`echo $i | sed 's/.*(\(.*\))/\1/'`

  awk "NR<$linenum" .tmp.new.txt > .tmp.pre.txt
  awk "NR>$linenum" .tmp.new.txt > .tmp.post.txt

  if [ `echo $file | grep ","` ]; then
    col=`echo $file | sed 's/.*,//'`
    file=`echo $file | sed 's/,.*//'`
    output=`$FOLD -c $col -i $file -o $file.potentially-folded`
    if [ $? -eq 1 ]; then
      echo "$FOLD -c $col -i $file -o $file.potentially-folded failed"
      echo "output: $output"
    fi
  else
    output=`$FOLD -i $file -o $file.potentially-folded`
    if [ $? -eq 1 ]; then
      echo "$FOLD -i $file -o $file.potentially-folded failed"
      echo "output: $output"
    fi
  fi

  cat .tmp.pre.txt $file.potentially-folded .tmp.post.txt > .tmp.new.txt
  rm $file.potentially-folded
done

cat .tmp.new.txt
rm .tmp.pre.txt .tmp.post.txt .tmp.new.txt


