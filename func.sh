#!/bin/bash
#Created by: Patka Zsolt-András
#On: 04.04.2018
#Function file
#Here is the code for the move, copy, delete, sync functions
#This script file is used by doer.sh
#	-move: 
#		syntax: move [-i] <from dir> <to dir>
#		description: Takes 2 arguments. Moves all of the files from <from dir> to <to dir>
#		options: -i - it runs in interactive mode (asks the user before any operation is executed)	
#		example: move dir1 dir2 (not interactive)
#				 move -i dir1 dir2 (interactive)
function move(){
	I=0 #interactive mode is false
	if(( $# > 3 ));then
		echo $(date '+%d-%m-%y %H:%M:%S') "Error inside move: Too many arguments: " $# >> doer.log
		printf "\n" >> doer.log
		return 1
	fi
	if [ "$1" == "-i" ];then #checks if it has interactive option
		I=1
		shift #shifts the arguments so $1 is dir1 and $2 is dir2
	fi
	if ! [ -d $1 ];then #checks if $1 exists and is a directory
		echo $(date '+%d-%m-%y %H:%M:%S') "Error inside copy: " $1 " not a directory or does not exist" >> doer.log
		printf "\n" >> doer.log
		return 1
	fi
	dir1=$1;
	if ! [ -d $2 ];then #checks if $2 exists and is a directory
		echo $(date '+%d-%m-%y %H:%M:%S') "Error inside copy: " $2 " not a directory or does not exist" >> doer.log
		printf "\n" >> doer.log
		return 1
	fi
	dir2=$2;
	if [ $I -eq 0 ]; then #not interactive mode
		mv $dir1 $dir2/$dir1
		echo $(date '+%d-%m-%y %H:%M:%S') "move: moved " $1 "to" $2/$1 >> doer.log
		printf "\n" >> doer.log
	else
		echo "Are you sure you want to move" $dir1 " inside " $dir2" ?[y/n]"
		#-n1 option: only reads one character
		#-s option: supresses input (doesn't echo it to the terminal)
		#responts: a variable, that is where we store the user input
		read -n1 -s response
		case $response in
			[y-Y])  mv $dir1 $dir2/$dir1 
					echo $(date '+%d-%m-%y %H:%M:%S') "move: moved " $1 "to" $2/$1 >> doer.log
					printf "\n" >> doer.log
					;; #if the user says Yes
			[n-N]) ;; #if the user says No
			*) ;; #dont do anything
		esac
	fi
}
#	-copy:
#		syntax: copy [-i] <from dir> <to dir>
#		description: Takes 2 argmuents. Copies all of the files from <from dir> to <to dir>
#		options: -i - it runs in interactive mode (asks the user before any operation is executed)	
#		example: copy dir1 dir2
#				 copy -i dir1 dir2
function copy(){
	I=0 #interactive mode is false
	if(( $# > 3 ));then
		echo $(date '+%d-%m-%y %H:%M:%S') "Error inside copy: Too many arguments: " $# >> doer.log
		printf "\n" >> doer.log
		return 1
	fi
	if [ "$1" == "-i" ];then #checks if it has interactive option
		I=1
		shift #shifts the arguments so $1 is dir1 and $2 is dir2
	fi
	if ! [ -d $1 ];then #checks if $1 exists and is a directory
		echo $(date '+%d-%m-%y %H:%M:%S') "Error inside copy: " $1 "not a directory or does not exist" >> doer.log
		printf "\n" >> doer.log
		return 1
	fi
	dir1=$1;
	if ! [ -d $2 ];then #checks if $2 exists and is a directory
		echo $(date '+%d-%m-%y %H:%M:%S') "Error inside copy: " $2 "not a directory or does not exist" >> doer.log
		printf "\n" >> doer.log
		return 1
	fi
	dir2=$2;
	if [ $I -eq 0 ]; then #not interactive mode
		cp -r $dir1 $dir2/$dir1
		echo $(date '+%d-%m-%y %H:%M:%S') "copy: copied" $1 "to" $2/$1 >> doer.log
		printf "\n" >> doer.log
	else
		echo "Are you sure you want to copy " $dir1 " inside " $dir2" ?[y/n]"
		#-n1 option: only reads one character
		#-s option: supresses input (doesn't echo it to the terminal)
		#responts: a variable, that is where we store the user input
		read -n1 -s response
		case $response in
			[y-Y])  cp -r $dir1 $dir2/$dir1 #-r option so it copies recursively
					echo $(date '+%d-%m-%y %H:%M:%S') "copy: copied" $1 "to" $2/$1 >> doer.log
					printf "\n" >> doer.log
					;; #if the user says Yes
			[n-N]) ;; #if the user says No
			*) ;; #dont do anything
		esac
	fi
}
#	-delete:
#		syntax: delete [-i] <dir>
#		description: Takes 1 argument. Deletes all of the filer in dir
#		options: -i - it runs in interactive mode (asks the user before any operation is executed)	
#		example: delete dir1
#				 delete -i dir1
function delete(){
	I=0 #interactive mode is false
	if(( $# > 2 ));then
		echo $(date '+%d-%m-%y %H:%M:%S') "Error inside delete: Too many arguments: " $# >> doer.log
		printf "\n" >> doer.log
		return 1
	fi
	if [ "$1" == "-i" ];then #checks if it has interactive option
		I=1
		shift #shifts the arguments so $1 is dir1 and $2 is dir2
	fi
	if ! [ -d $1 ];then #checks if $1 exists and is a directory
		echo $(date '+%d-%m-%y %H:%M:%S') "Error inside delete " $1 " is not a directory or does not exist" >> doer.log
		printf "\n" >> doer.log
		return 1
	fi
	dir1=$1;
	if [ $I -eq 0 ]; then #not interactive mode
		rm -r $dir1
		echo $(date '+%d-%m-%y %H:%M:%S') "delete: deleted" $1 >> doer.log
		printf "\n" >> doer.log
	else
		echo "Are you sure you want to delete " $dir1 " and all of its subfolders and files?[y/n]"
		#-n1 option: only reads one character
		#-s option: supresses input (doesn't echo it to the terminal)
		#responts: a variable, that is where we store the user input
		read -n1 -s response
		case $response in
			[y-Y])  rm -r $dir1 #-r option so it copies recursively
					echo $(date '+%d-%m-%y %H:%M:%S') "delete: deleted" $1 >> doer.log
					printf "\n" >> doer.log
					;; #if the user says Yes
			[n-N]) ;; #if the user says No
			*) ;; #dont do anything
		esac
	fi
}



#	-sync:
#		syntax: sync [-i] [-c] <dir1> <dir2>
#		description: Takes 2 arguments. Synchronizes the two directories. All of the files from dir1 which are not present
#					 in dir2 get copied to dir2 and vice versa.
#		options: -i - it runs in interactive mode (asks the user before any operation is executed)	
#				 -c - it compares the files by content. If this option is missing then the files get compared by name.
function sync(){
	I=0 #interactive mode is false
	C=0 #Compare by content is false

	if(( $# > 4 ));then
		echo $(date '+%d-%m-%y %H:%M:%S') "Error inside sync: Too many arguments: " $# >> doer.log
		printf "\n" >> doer.log
		return 1
	fi
	while (( $# > 2 )); do
		case $1 in
			-i) I=1; shift;; #checks for interactive mode, shifts
			-c) C=1; shift;; #checks for compare by content mode, shifts
			*);;
		esac
	done

	if ! [ -d $1 ];then #checks if $1 exists and is a directory
		echo $(date '+%d-%m-%y %H:%M:%S') "Error inside sync: " $1 " not a directory or does not exist" >> doer.log
		printf "\n" >> doer.log
		return 1
	fi
	dir1=$1;
	if ! [ -d $2 ];then #checks if $2 exists and is a directory
		echo $(date '+%d-%m-%y %H:%M:%S') "Error inside sync: " $2 " not a directory or does not exist" >> doer.log
		printf "\n" >> doer.log
		return 1
	fi
	dir2=$2;
	list1=$(ls $dir1)
	list2=$(ls $dir2)

	if [ $C -eq 0 ];then #compare by name
		for elem1 in $list1 #goes through list1, copies from dir1->dir2
		do
			present=0
			for elem2 in $list2 #goes through list2
			do
				if [ "$elem1" == "$elem2" ];then #if two elements are the same, then 
					present=1
					break
				fi
			done
			if (( $present == 0 ));then
				if (( I == 0 )); then
					cp -r $dir1/$elem1 $dir2/$elem1
				else #Interactive mode
					echo "Are you sure you want to copy " $elem1 " to " $dir2" ?[y/n]"
					#-n1 option: only reads one character
					#-s option: supresses input (doesn't echo it to the terminal)
					#response: a variable, that is where we store the user input
					read -n1 -s response
					case $response in
						[y-Y])  echo $response
								cp -r $dir1/$elem1 $dir2/$elem1 #-r option so it copies recursively
								;; #if the user says Yes
						[n-N]) ;; #if the user says No
						*) ;; #dont do anything
					esac
				fi
				echo $(date '+%d-%m-%y %H:%M:%S') "sync: copied " $elem1 " to " $dir2 >> doer.log
				printf "\n" >> doer.log
			fi
		done
		list1=$(ls $dir1)
		list2=$(ls $dir2)
		for elem2 in $list2 #goes through list2, copies from dir2->dir1
		do
			present=0
			for elem1 in $list1 #goes through list1
			do
				if [ "$elem1" == "$elem2" ];then
					present=1
					break
				fi
			done
			if (( $present == 0 ));then
				if (( I == 0 ));then
					cp -r $dir2/$elem2 $dir1/$elem2
				else
					echo "Are you sure you want to copy " $elem2 " to " $dir1" ?[y/n]"
					read -n1 -s response
					case $response in
						[y-Y])  cp -r $dir2/$elem2 $dir1/$elem2 #-r option so it copies recursively
								;; #if the user says Yes
						[n-N]) ;; #if the user says No
						*) ;; #dont do anything
					esac
				fi
				echo $(date '+%d-%m-%y %H:%M:%S') "sync: copied " $elem2 " to " $dir1 >> doer.log
				printf "\n" >> doer.log
			fi
		done
	else #compare by content
		for elem1 in $list1 #goes through list1
		do
			present=0
			for elem2 in $list2 #goes through list2
			do
				difference=$(diff $dir1/$elem1 $dir2/$elem2)
				if [ "$difference" == "" ];then #if two elements are the same, then 
					present=1
					break
				fi
			done
			if (( $present == 0 ));then
				if (( I == 0 )); then
					cp -r $dir1/$elem1 $dir2/$elem1
				else #Interactive mode
					echo "Are you sure you want to copy " $elem1 " to " $dir2" ?[y/n]"
					read -n1 -s response
					case $response in
						[y-Y])  cp -r $dir1/$elem1 $dir2/$elem1 #-r option so it copies recursively
								;; #if the user says Yes
						[n-N]) ;; #if the user says No
						*) ;; #dont do anything
					esac
				fi
				echo $(date '+%d-%m-%y %H:%M:%S') "sync: copied " $elem1 " to " $dir2 >> doer.log
				printf "\n" >> doer.log
			fi
		done
		list1=$(ls $dir1)
		list2=$(ls $dir2)
		for elem2 in $list2 #goes through list2
		do
			present=0
			for elem1 in $list1 #goes through list1
			do
				difference=$(diff $dir1/$elem1 $dir2/$elem2)
				if [ "$difference" == "" ];then #if two elements are the same, then 
					present=1
					break
				fi
			done
			if (( $present == 0 ));then
				if (( I == 0 ));then
					cp -r $dir2/$elem2 $dir1/$elem2
				else
					echo "Are you sure you want to copy " $elem2 " inside " $dir1" ?[y/n]"
					read -n1 -s response
					case $response in
						[y-Y])  cp -r $dir1/$elem1 $dir2/$elem1 #-r option so it copies recursively
								;; #if the user says Yes
						[n-N]) ;; #if the user says No
						*) ;; #dont do anything
					esac
				fi
				echo $(date '+%d-%m-%y %H:%M:%S') "sync: copied " $elem2 " to " $dir1 >> doer.log
				printf "\n" >> doer.log
			fi
		done
	fi
		
}