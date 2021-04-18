​#!/bin/sh
​
​#size of the virus
​VIRUS_SIZE=10710
​
​#size of the virus mark
​MAGIC_SIZE=4
​
​#infected source as 1. command line parameter
​INFECTED=$1
​
​#is parameter entered?
​if [ -z "$INFECTED" ];then
​	echo "Using $0 <infected file>"
​	exit 1
​fi
​
​#current infection size
​INFECTED_SIZE=`ls -l $INFECTED| awk '$5 {print $5}'`
​#original program size
​let ORIG_SIZE=$INFECTED_SIZE-$VIRUS_SIZE-$MAGIC_SIZE
​
​echo "Size of the virus: $VIRUS_SIZE"
​echo "Size of the original program: $ORIG_SIZE"
​#infection copy
​mv $INFECTED $INFECTED.vx
​#extraction of oroginal program
​dd if=$INFECTED.vx of=$INFECTED count=$ORIG_SIZE skip=$VIRUS_SIZE bs=1
​
​#file permissions
​chmod $INFECTED --reference $INFECTED.vx