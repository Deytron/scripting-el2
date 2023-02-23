#!/bin/bash
# Auth users
# Made by Romain Ranaivoson
# Last update: 2023-02-23
# -------------------------------------------
# To use this script, run ./auth.sh
# With arguments like -i or -s
# No Windows here sorry boy
# -------------------------------------------

### Variables
FOUND=0

echo 'Gestion utilisateurs'
echo

read -p 'Login : ' LOGIN

IFS='
'
while read line; do  
        if grep -q $LOGIN passwd;then
            read -p "User found. Input password : " PASS
            CURRENTPASS=$line | grep -q '\$.*:'
            RESULT=$($PASS | sha512sum)
            if [[ $RESULT == $CURRENTPASS ]]; then
                echo 'Correct password'
                break
            else
                echo 'Wrong password'
            fi
        else
            echo 'User not found'
        fi
done < passwd

exit 0