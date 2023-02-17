#!/bin/bash
# 10Pass
# Made by Romain Ranaivoson
# Last update: 2023-02-17
# -------------------------------------------
# To use this script, either run ./start.sh before
# or run ./10pass.sh
# No Windows here sorry boy
# -------------------------------------------

### Variables
L=0
CHAR=({a..Z} {A..Z} {0..9} '/' '.' '-' ',')
NBC=${#CHAR[@]}
YES=""

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
read -p 'Should I generate a password for you ? [y/n] : ' YES

function input {
    while [[ ! $YES =~ ^[yYnN]$ ]]; do
        echo ''
        echo "I don't know what you are trying to do"
        read -p 'Should I generate a password for you ? [y/n] : ' YES
    done
}

function long {
    while [[ ! $L =~ ^[1-9]+$ ]]; do
        echo ''
        echo "Just give me a valid number man"
        read -p "Give me the password length : " L
    done
}

function passwordsnumber {
    while [[ ! $PN =~ ^[1-9]+$ ]]; do
        echo ''
        echo "Just give me a valid number man"
        read -p "How many passwords do you want to generate ? : " PN
    done
}

input

if [[ $YES =~ ^[yYnN]$ ]]; then
    read -p "Give me the password length : " L
    long
fi

if [[ ! $L == 0 ]]; then
    read -p "How many passwords do you want to generate ? : " PN
    passwordsnumber
fi


# Function to generate a random password, 10 characters long

function generate_pass {
    for c in $(seq 1 $L); do
        i=$(( $RANDOM % $NBC ))
        echo ${CHAR[$i]}
    done
    echo ''
}

if [[ $YES == "y" || "Y" ]]; then
    echo 'Alright. Here are your passwords :'
    echo ''
    for i in $(seq $PN); do
        generate_pass
    done
    echo ''
    echo 'Muahaha. I will always be here for you. Come back anytime.'
else
    echo ''
    echo 'Alright. Guess you got here by accident. See you later comrade.'
    echo ''
fi


exit 0