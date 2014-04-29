file=$1
template=$2
body=`python md2body.py $file`
#python md2body.py $file
body=`echo "$body"`
file=`basename $file`
html=${file%.*}.html
rm $BLOG/blog/$html
cat $template | while read line
do
  ans=`echo $line | grep "&"`
  if [ "$ans" = "" ] 
  then
    echo "$line" >> $BLOG/blog/$html
  else
    echo "$body" >> $BLOG/blog/$html
  fi
done
#body="/home/polym/work/blog/note/awk_cs.md <h1>AWK--</h1> <blockquote>"
#sed "s#\&#${body}#g" $template > $BLOG/blog/$html
echo -e "generated \$BLOG/note/$file to \$BLOG/blog/$html"
