file=$1
template=$2

title="Polym's Blog| "`head -1 $1 | cut -c2-`
day=`stat -c %y $1 | grep -o '\-[0-9]\{2\} ' | cut -c2-3`
year=`stat -c %y $1 | grep -o '[0-9]\{4\}\-' | cut -c1-4`
month=`stat -c %y $1 | grep -o '\-[0-9]\{2\}\-' | cut -c2-3`
month=$month"/"$year

body=`python md2body.py $file`
#python md2body.py $file
body=`echo "$body"`
file=`basename $file`
html=$BLOG/blog/${file%.*}.html
rm $html
cat $template | while read line
do
  case $line in
	"TITLE")
	echo "$title" >> $html
	;;
	"DAY")
	echo "$day" >> $html
	;;
	"MONTH")
	echo "$month" >> $html
	;;
	"ARTICLE")
	echo "$body" >> $html
	;;
	*)
	echo $line >> $html
	;;
  esac
#  
#  ans=`echo "$line" | grep "ARTICLE"`
#  if [ "$ans" = "" ] 
#  then
#	ans=`echo "$line" | grep "TITLE"`
#	if [ "$ans" = ""
#  else
#    echo "$body" >> $BLOG/blog/$html
#  fi
done
#body="/home/polym/work/blog/note/awk_cs.md <h1>AWK--</h1> <blockquote>"
#sed "s#\&#${body}#g" $template > $BLOG/blog/$html
echo -e "generated \$BLOG/note/$file to \$BLOG/blog/$html"
