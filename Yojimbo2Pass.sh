#!/bin/bash

# directory where the yojimbo password files live 
FILES=./yojimbo/*

for f in $FILES
do
	# remove the .txt
	pass_name="${f/.txt/}"

	# replace spaces with dashes
	pass_name=`echo $pass_name | tr " " "-"`

	# make the name lower case
	pass_name=`echo $pass_name | tr '[:upper:]' '[:lower:]'`

	# remove the ./yojimbo/ in the file name
	pass_name="${pass_name/'./yojimbo/'}"

	# find the password line and the text after it
	pass=$(cat "$f" | grep ^Password | awk '{print $2}')

	# put the password at the top of the file
	sed -i "1s/^/${pass}\n/" "$f"
	
	# cat the file into pass
	cat "$f" | pass insert -m $pass_name

done
