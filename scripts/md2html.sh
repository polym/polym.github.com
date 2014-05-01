file=$1
html=$2
template=$3
flag=$4
nhtml=`basename $file`
nhtml=${nhtml%.*}.html

title="Polym's Blog| "`head -1 $1 | cut -c2-`
day=`stat -c %y $1 | grep -o '\-[0-9]\{2\} ' | cut -c2-3`
year=`stat -c %y $1 | grep -o '[0-9]\{4\}\-' | cut -c1-4`
month=`stat -c %y $1 | grep -o '\-[0-9]\{2\}\-' | cut -c2-3`
month=$month"/"$year

body=`python md2body.py $file`
#python md2body.py $file
body=`echo "$body"`
#file=`basename $file`
#html=$BLOG/blog/${file%.*}.html
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
done
#body="/home/polym/work/blog/note/awk_cs.md <h1>AWK--</h1> <blockquote>"
#sed "s#\&#${body}#g" $template > $BLOG/blog/$html
echo "generated $file to $html"
