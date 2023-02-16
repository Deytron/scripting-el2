#!/bin/bash
# Start menu for scripts
# Made by Romain Ranaivoson
# Last update: 2023-02-16
# -------------------------------------------
# To use this script, simply run it from the command line with your folder
# Example : ./start.sh
# You may have to do 'chmod +x start.sh' to have it working
# No Windows here sorry boy
# -------------------------------------------

### Variables
CHOICE=0

chmod +x *

function checkinput {
    sleep 1

    if [[ $CHOICE == 1 ]]; then
        ./givemethemonth.sh
    fi
    if [[ $CHOICE == 2 ]]; then
        ./10pass.sh
    fi
    if [[ $CHOICE == 3 ]]; then
        ./filelight.sh
    fi
    if [[ $CHOICE == 4 ]]; then
        ./bigbrain.sh
    fi
    if [[ $CHOICE == 5 ]]; then
        ./givemetheip.sh
    fi

    wait $job_pid
    next
}

function readinput {
    # Exit on 0
    if [[ $CHOICE == 0 ]]; then
        echo 'See you later !'
        exit 0
    fi

    while [[ ! $CHOICE =~ ^([0-9]|10)$ ]]; do
        echo ''
        echo "Well, that's not a valid number"
        read -p 'Enter your choice here : ' CHOICE
    done

    echo 'Choice number' $CHOICE 'huh ? Excellent choice.'
    echo 'Here you go then.'
    echo ''

    checkinput
}

function showmenu {
    echo '    /\_____/\
   /  o   o  \
  ( ==  ^  == )
   )         (
  (           )
 ( (  )   (  ) )
(__(__)___(__)__)'


    echo ''
    echo 'Hello ! Please select an activity below'
    echo ''

    # Loop through files, useful if any is added
    # for filename in $A; do
    #     i=$((i+1))
    #     echo $i. "${filename%.*}"
    # done

    echo '1. Give me the month'
    echo '2. 10Pass'
    echo '3. FileLight'
    echo '4. Bigbrain calculator'
    echo '0. Exit'

    read -p 'Enter your choice here : ' CHOICE
    readinput
}

function next {
    echo ''
    echo '----------------------------'
    echo ''
    echo 'Looks like your activity is done.'
    read -p 'Press enter to continue' NULL
    sleep 1
}

while true; do
    clear
    showmenu
done
