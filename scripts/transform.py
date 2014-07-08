#!/usr/bin/python
class TransRobot:
    ''' 
    __init__ : initialize list for replace 
    n2c		 : name to content 
    transline: transform a line 
    transfile: transform a file 
    '''

    def __init__(self, mps):
        self.mps = mps

    def n2c(self, word):
        return self.mps[word]
		
    def transline(self, line):
        res = word = ''
        flag = 0
        for i in range(len(line)):
            if(line[i] == '$'):
                if(flag == 0):
                    flag = 1
                else:
                    flag = 0
                    res += self.n2c(word)
                    word = ''
            else:
                if(flag == 0):
                    res += line[i]
                else:
                    word += line[i]
        return res

    def transfile(self, filename):
        filestr = ''
        for line in open(filename):
            print line
            filestr += self.transline(line)
        return filestr

