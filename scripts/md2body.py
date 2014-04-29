import sys
import markdown
def md2html(filename):
  head = ''
  input_file=open(filename)
  text = input_file.read()
  text = unicode(text, 'utf-8')
  html = markdown.markdown(text)
  head += html
  html = head.encode('utf-8')
  print html

cmdargs = sys.argv[1:]  
if len(cmdargs) > 0:
  for k in cmdargs:
#    print k
    md2html(k)
