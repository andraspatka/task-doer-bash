Created by: Patka Zsolt-András
On: 04.04.2018
Executes tasks written in tasks.txt
Tasks can be: move, copy, delete, sync.
The tasks' script can be found in the func.sh script file
This script can only run in one instance
Arguments: $1 - the path to the file including the tasks
			if $1 is missing then the tasks included in tasks.txt get executed
Examples for calling do.sh:
	- do.sh
	- do.sh tasks.txt
Tasks:
	-move: 
		syntax: move [-i] <from dir> <to dir>
		description: Takes 2 arguments. Moves all of the files from <from dir> to <to dir>
		options: -i - it runs in interactive mode (asks the user before any operation is executed)	
		example: move dir1 dir2 (not interactive)
				 move -i dir1 dir2 (interactive)
	-copy:
		syntax: copy [-i] <from dir> <to dir>
		description: Takes 2 argmuents. Copies all of the files from <from dir> to <to dir>
		options: -i - it runs in interactive mode (asks the user before any operation is executed)	
		example: copy dir1 dir2
				 copy -i dir1 dir2
	-delete:
		syntax: delete [-i] <dir>
		description: Takes 1 argument. Deletes all of the filer in dir
		options: -i - it runs in interactive mode (asks the user before any operation is executed)	
		example: delete dir1
				 delete -i dir1
	-sync:
		syntax: sync [-i] [-c] <dir1> <dir2>
		description: Takes 2 arguments. Synchronizes the two directories. All of the files from dir1 which are not present
					 in dir2 get copied to dir2 and vice versa.
		options: -i - it runs in interactive mode (asks the user before any operation is executed)	
				 -c - it compares the files by content. If this option is missing then the files get compared by name.
