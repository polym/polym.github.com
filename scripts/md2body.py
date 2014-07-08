#!/usr/bin/python
import sys
import os
import time
import datetime
import markdown
import transform

TEMPLATE = 'version1.1.3'

def md2html(filename):
    head = ''
    input_file=open(filename)
    text = input_file.read()
    text = unicode(text, 'utf-8')
    html = markdown.markdown(text)
    head += html
    html = head.encode('utf-8')
    return html

def create_blog(title, filename, create_time, template):
    filename = os.getcwd() + '/note/' + filename
    template = os.getcwd() + '/template/' + template
    body = md2html(filename)
    args = {}
    args['TITLE'] = title
    args['BODY'] = body
    arr = time.strptime(create_time, '%Y-%m-%d  %H:%M:%S')
    args['YEAR'] = str(arr[0])
    args['MONTH'] = str(arr[1])
    args['DAY'] = str(arr[2])
    args['HOUR'] = str(arr[3])
    args['MINS'] = str(arr[4])
    args['SECD'] = str(arr[5])
    robot = transform.TransRobot(args)
    return robot.transfile(template)

def add_blog(title, filename):
    now = datetime.datetime.now()
    now = now.strftime("%Y-%m-%d %H:%M:%S")
    print now

    # backup
    f = open('.transList', 'w+')
    f.write(now+'\t'+title+'\t'+filename)
    f.close()
    
    # blog page
    blog = create_blog(title, filename, now, TEMPLATE)
    f = open('./blog/'+filename.split('.')[0]+'.html', 'w')
    f.write(blog)
    f.close()

    # index page
    # blog = create_blog(title, filename, now, INDEX)
    # f = open('./blog/index.html', 'w')

if __name__ == '__main__':
    cmdargs = sys.argv[1:]
    if(cmdargs[0] == 'add'):
        add_blog(cmdargs[1], cmdargs[2])
