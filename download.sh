#!/bin/bash

# 下载（更新）必要的组件
# 在build之前执行，定时更新即可

if [ ! -d ext ]
then
    mkdir ext 
fi

cd ext

# sources.list
filename=sources.list
rm $filename
wget https://raw.githubusercontent.com/IBBD/docker-compose/master/sources.list/debian/$filename -O $filename

# 判断是否操作成功
filesize=$(ls -l $filename | awk '{ print $5 }')
if [ $filesize -lt 10 ]
then
    echo "$filename is empty!"
    exit 1
fi

# vim配置文件
filename=spf13-vim.sh
curl https://j.mp/spf13-vim3 -L > $filename

# 判断是否操作成功
filesize=$(ls -l $filename | awk '{ print $5 }')
if [ $filesize -lt 10 ]
then
    echo "$filename is empty!"
    exit 1
fi


echo "===> Finish!"

