#!/bin/bash
​
​
​#check for command line parameter
​if test -z $1 
​then
​	echo "Using $0 directory"
​	exit 1
​fi
​
​path="$1"
​DB="crc.sum"
​
​# list the dir, search for executable files
​for file in `find $path -perm /111 -print | sed '1d'`
​do
​	#test existence of checksum database
​	if test -f $DB
​	then
​		if grep -q $file $DB 
​		then
​			#checksum exists, it is compared
​			#current sum
​			sumcurr=`sha1sum $file | gawk '{print $1}'`
​			#saved sum
​			sumsav=`grep $file $DB | gawk '{print $1}'`
​			
​			#comparison
​			if test "$sumcurr" == "$sumsav"
​			then
​				:
​			else
​				echo "Checksum changed for file: $subor"
​			fi
​		
​		else
​			#checksum does not exists, it is saved
​			sha1sum $file >> $DB
​		fi
​	else		
​	      #checksum does not exists, it is saved
​	      sha1sum $file >> $DB
​	fi	
​done
​exit 0