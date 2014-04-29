template=$BLOG/template/version1.1.1
for file in $BLOG/note/*.md
do
  echo "processing $file ..."
  $BLOG/scripts/md2html.sh $file $template
  file=`basename $file`
done
tree $BLOG/blog
