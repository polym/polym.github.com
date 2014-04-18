import sys
import markdown
inpath="../note/"
outpath="../blog/"
def md2html(filename):
  head = ''
  input_file=open(inpath+filename)
  text = input_file.read()
  html = markdown.markdown(text)
  title= unicode(filename, "utf-8")
  outfile = open(outpath+filename+'.html', "w")
  head = '<!DOCTYPE html>'
  head += '<html><head><meta charset="utf-8"/><title>' + title + '</title><link href="demo.css" type="text/css" rel="stylesheet"/></head><body>'
  head += html
  head += '</body></html>\n'
  html = head.encode('utf-8')
  outfile.write(html)
  outfile.close()

cmdargs = sys.argv[1:]  
if len(cmdargs) > 0:
  for k in cmdargs:
    md2html(k)
