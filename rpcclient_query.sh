#!/bin/sh
#enumerate rpcclient from users.txt
if [[ $# -eq 0 ]] ; then
	echo ".\script <ip>"
	echo "No IP supplied"
	exit 1 
fi

rpcclient -U "" -N $1 -c "enumdomusers" > users.txt
sed -e  's/user\:\[//g' users.txt > users.tmp.txt
sed 's/\].*//g' users.tmp.txt > users.txt
rm users.tmp.txt
echo -e "Deleting users_query1234567890.txt if it exists"
rm users_query1234567890.txt
echo -e "Users found:" ;
#queryuser
while read u; do
	echo -n -e "$u\n" && rpcclient -U "" -N $1 -c "queryuser $u" >> users_query1234567890.txt
done <users.txt
