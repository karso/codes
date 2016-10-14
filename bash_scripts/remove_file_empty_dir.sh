#!/bin/bash
echo "Enter the directory name"
read dir_name
dir_name=test

function remove_dir {
	if [ "$(ls -A $1)" ]; then
		for entry in $(`ls $1`); do
			if [ -f "$entry" ]; then 
				echo "Removing $entry"
			else
				remove_dir $entry
			fi
		done
	else
		echo "Removing $1"
	fi
}

remove_dir $dir_name
