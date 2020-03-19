#!/bin/bash
save=/root/summary.txt
recur()
{
	local dir=(`ls -d */ 2>/dev/null`)
	for t in ${dir[@]}
	do
		cd $t
		recur
		local A=(`ls *.mp3 *.acc *.mp4 *.mov *.avi *.vid 2>/dev/null`)
		if test ${#A[*]} -gt 0
		then
			echo media files removed at `pwd`:>>$save
			local total=0
			for str in ${A[*]}
			do
				local num=`stat -c %s $str`
				echo $str $num bytes
				let total+=num 
			done>>$save
			echo total size: $total bytes>>$save
			echo>>$save
			rm `echo ${A[*]}`
		fi
		cd ..
	done
}
cd $1
echo `date`:>$save
recur
echo summary.txt saved at /root
