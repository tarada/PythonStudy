#-*-coding:utf-8-*-
import os#读取文件的路径需要用的包

with open('/home/xt/文档/作业/太空旅客.txt', 'r') as f:

    page = f.read()

def fun(file):#定义一个计算次数的函数

    c = {}#创建一个字典

    sum = 0#初始化sum为0

    for line in set(file.readlines()):#得到一个以行划分的列表

        line = line.strip()#去空格和换行符

        c[line] = page.count(line)

        sum += c[line]

    return sum

def GetFileList(dir, fileList):#将不同目录下的文件合并在一起

    if os.path.isfile(dir):#如果输入的dir是文件,则把文件传入列表

        fileList.append(dir)

    elif os.path.isdir(dir):#dir是目录,把目录下的东西分成一个个的

        for s in os.listdir(dir):

            newDir = os.path.join(dir, s)

            GetFileList(newDir, fileList)

    return fileList


lista = GetFileList(r'/home/xt/文档/作业/词典/', [])#把词典下所有的文件都弄进这一个列表中

dict={}

for e in lista:
#lista中每一个文件的路径,e是每个txt文件的路径
    dict[fun(open(e, 'rb'))] = open(e, 'rb').name.split('词典/')[1].strip('.txt')


for a in lista:

    print a


for key,value in dict.items():#打印字典

    print '%-10s%s' %(key,value)#加入空格,增强可读性

maxnum = max(dict.keys())

print '人们最高关注点为' + dict[maxnum]

