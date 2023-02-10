#!/bin/bash
# 10Pass
# Made by Romain Ranaivoson
# Last update: 2023-02-10
# -------------------------------------------
# To use this script, either run ./start.sh before
# or run ./10pass.sh with an argument
# No Windows here sorry boy
# -------------------------------------------

### Variables
TAB=""
CHOICE=""

echo '  .   *   ..  . *  *
*  * @()Ooc()*   o  .
    (Q@*0CG*O()  ___
   |\_________/|/ _ \
   |  |  |  |  | / | |
   |  |  |  |  | | | |
   |  |  |  |  | | | |
   |  |  |  |  | | | |
   |  |  |  |  | | | |
   |  |  |  |  | \_| |
   |  |  |  |  |\___/
   |\_|__|__|_/|
    \_________/
'

echo '10Pass'
echo ''
echo 'The best password generator in the west. But only with 10 characters.'
sleep 2
echo ''
read -p 'Should I generate a password for you ? [y/n] : ' CHOICE

function input {
    while [[ ! $CHOICE =~ ^[yYnN]$ ]]; do
        echo ''
        echo "I don't know what you are trying to do"
        read -p 'Should I generate a password for you ? [y/n] : ' CHOICE
    done
}

input

# Function to generate a random password, 10 characters long

function generate_pass {
    # One obvious thing I could do is using OpenSSL :P
    # But let's make it the old way
    for i in {1..10}; do
        type=$(( $RANDOM % 3 ))
        if [[ $type == 0 ]]; then
            i=$(echo $RANDOM | md5sum | head -c 1 )
            echo
        fi
        if [[ $type == 1 ]]; then
            i=$(( $RANDOM % 9 ))
        fi
        if [[ $type == 2 ]]; then
            i=$(echo "_-+=)({@}" | sed 's/./&\n/g' | grep . | shuf | head -1)
        fi
    TAB+=$i
    done
    echo $TAB
}

if [[ $CHOICE == "y" || "Y" ]]; then
    echo 'Alright. Here is your password :'
    echo ''
    generate_pass
    echo ''
    echo 'Muahaha. I will always be here for you. Come back anytime.'
else
    echo ''
    echo 'Alright. Guess you got here by accident. See you later comrade.'
    echo ''
fi


exit 0