#!/bin/bash
#Created by: Patka Zsolt-András
#On: 04.04.2018
#Executes tasks written in tasks.txt
#Tasks can be: move, copy, delete, sync.
#The tasks' script can be found in the func.sh script file
#This script can only run in one instance
#Arguments: $1 - the path to the file including the tasks
#			if $1 is missing then the tasks included in tasks.txt get executed
#Examples for calling do.sh:
#	- do.sh
#	- do.sh tasks.txt
#Tasks:
#	-move: 
#		syntax: move [-i] <from dir> <to dir>
#		description: Takes 2 arguments. Moves all of the files from <from dir> to <to dir>
#		options: -i - it runs in interactive mode (asks the user before any operation is executed)	
#		example: move dir1 dir2 (not interactive)
#				 move -i dir1 dir2 (interactive)
#	-copy:
#		syntax: copy [-i] <from dir> <to dir>
#		description: Takes 2 argmuents. Copies all of the files from <from dir> to <to dir>
#		options: -i - it runs in interactive mode (asks the user before any operation is executed)	
#		example: copy dir1 dir2
#				 copy -i dir1 dir2
#	-delete:
#		syntax: delete [-i] <dir>
#		description: Takes 1 argument. Deletes all of the filer in dir
#		options: -i - it runs in interactive mode (asks the user before any operation is executed)	
#		example: delete dir1
#				 delete -i dir1
#	-sync:
#		syntax: sync [-i] [-c] <dir1> <dir2>
#		description: Takes 2 arguments. Synchronizes the two directories. All of the files from dir1 which are not present
#					 in dir2 get copied to dir2 and vice versa.
#		options: -i - it runs in interactive mode (asks the user before any operation is executed)	
#				 -c - it compares the files by content. If this option is missing then the files get compared by name.


. func.sh #loads the file containing the script for the tasks
tasks="tasks.txt" #Default task file
if (( $# > 1 )); then #More than 1 arguments, could cause undefined behaviour
	echo "Too many arguments: " $#
	exit 0
fi
if (( $# == 1 )); then #Exactly one argument
	if ! [ -a $1 ];then #The file from the argument list exists
		echo "Input file" $1 "does not exist"
		exit 0;
	fi
fi

pid=$(pgrep doer.sh) #returns a list delimitated by spaces of all of the currently running do.sh pid numbers
if ! [ -a doer.pid ]; then #if the pid file does not exist
	touch doer.pid
	echo $(date '+%d-%m-%y %H:%M:%S') "started: doer.sh" >> doer.log
	printf "\n" >> doer.log
	echo $pid >> doer.pid
else #If the pid file exists, it means that an instance is already running
	exit 0;
fi
#If it gets TERM INT QUIT signals, it writes to the log file and deletes the pid file, also exits with 0 error code
trap "echo $(date '+%d-%m-%y %H:%M:%S') exit_signal >> doer.log; printf "\n" >> doer.log; rm doer.pid; exit 0" TERM INT QUIT

nr=$(wc -l $tasks | cut -c1)

i=1
#prints a new line into tasks.txt (it is needed so the last task doesn't potentially get ignored)
printf "\n" >> $tasks 
while (( $i <= $nr ))
do #reads from $tasks line by line
	com=$(sed -n "$i p" $tasks) #uses sed to print a line from $tasks
	read c1 c2 c3 c4 c5 <<< $com #reads arguments from the line
	case $c1 in
		move) move $c2 $c3 $c4
			;;
		copy) copy $c2 $c3 $c4
			;;
		sync) sync $c2 $c3 $c4 $c5
			;;
		delete) delete $c2 $c3
			;;
		*) echo $(date '+%d-%m-%y %H:%M:%S') "incorrect task" >> doer.log; printf "\n" >> doer.log;;
	esac
	i=$(( $i + 1 ))
done

rm doer.pid