#!/bin/bash


uid=$UID

if test $uid -ne 0; then
	echo "User id är inte 0"
fi

for user in "$@"; do
	#skapa användare
	useradd -m "$user"
	

	#skapa ny användarmapp + undermappar
	new_dir="/home/$user"

	mkdir -p "$new_dir/Documents"
	mkdir -p "$new_dir/Downloads"
	mkdir -p "$new_dir/Work"

	#rättigheter till user
	chown -R "$user" "$new_dir"

	chmod 600 "$new_dir"

	#skapa välkomstfil
	welcome_file="$new_dir/welcome.txt"
	echo "Välkommen $user" > "$welcome_file"
	echo " " >> "$welcome_file"
	echo "Andra användare: " >> "$welcome_file"
	
	cut -d: -f1 /etc/passwd | grep -v "^$USERNAME$" >> "$welcome_file"
done
