#take dir name as 1st argument which contains the verified sentences in usr.csv format and run all the user.csv files and stores the output in my_out file.
#To run:
# python runVerifiedSents.py verified_sent

import sys, commands, os
dire = sys.argv[1]
files = os.listdir(dire)

files.sort()
commands.getoutput('rm my_temp.txt')
for f in files :
    fw = open('my_temp.txt', 'a')
    fw.write("\nINPUT_SENTENCE: " + f)
    cmd = 'bash lc.sh ' + dire + '/' + f + ' jnk'
#    cmd = 'bash lc.sh ' + dire + '/' + f + ' jnk >>my_out'
    myout = commands.getoutput(cmd)
    fw.write(myout)
    fw.close()


fr = open('my_temp.txt', 'r')
flst = fr.readlines()
flag = 0
for l in flst:
    if "INPUT_SENTENCE: " in l:
        print
        print l[16:-32]
        print
    if 'gnp labels' in l:
        flag = 1

    if '         CLIPS (Cypher Beta' in l or l.startswith('NOTE: '):
        flag = 0

    if flag == 1 and "['" not in l and  'gnp labels' not in l :
        print l,
