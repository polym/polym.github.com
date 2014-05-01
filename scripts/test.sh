addhref () {
	: > $1.tmp
	cat $1 | while read line
	do
	  var=`echo $line | grep h1`
	  if [ "$var" != "" ]
	  then
		echo "<a href=\"$2\">$line</a>" >> $1.tmp
	  else
		echo $line >> $1.tmp
      fi
	done
	mv $1.tmp $1
}
export WORK=$HOME/work
export BLOG=$WORK/blog

template=$BLOG/template/version1.1.2
index=$BLOG/template/article
ihtml=$BLOG/blog/index.html
itemplate=$BLOG/template/index1.1.1
tmpfile=$BLOG/tmp/tmpfile
art=$BLOG/tmp/art

:>$tmpfile
:>$ihtml

for file in `ls -t $BLOG/note/ | grep "md$"`	 
do
  file="$BLOG/note/"$file
  echo "processing $file ..."
  html=`echo ${file%.*}.html | sed 's/note/blog/g'`
  :>$html
  :>$art
# generate single page
  $BLOG/scripts/md2html.sh $file $html $template
# generate for index
  $BLOG/scripts/md2html.sh $file $art $index 
  addhref $art /blog/${html##*/}
  cat $art >> $tmpfile
done

cat $itemplate | while read line 
do
  if [ "$line" == "LITTLE" ]
  then
	cat $tmpfile >> $ihtml
  else
	echo $line >> $ihtml
  fi
done

tree $BLOG/blog
