#!/bin/bash

cd ~/Desktop

INFI=$1
OUTFI=$2

if [ ! -f $INFI ]; then
    echo "Input file doesn't exist!"
    exit 1
fi

if [ -f $OUTFI ]; then
    rm -f $OUTFI
fi

echo -e "$(date)\n" >> $OUTFI
cat $INFI |
while read pcname; do
    ping -w 3 $pcname
    if [ $? -gt 0 ]; then
        continue
    fi
    ssh -n -o BatchMode=yes $pcname w | grep "0 users"
    if [ $? -eq 0 ]; then
        echo $pcname >> $OUTFI
    fi
done 
