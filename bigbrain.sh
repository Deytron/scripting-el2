#!/bin/bash
# Bigbrain
# Made by Romain Ranaivoson
# Last update: 2023-02-10
# -------------------------------------------
# To use this script, either run ./start.sh before
# or run ./bigbrain.sh with an argument
# No Windows here sorry boy
# -------------------------------------------

### Variables
MATH=""


echo '   _____________________
|  _________________  |
| | JO           0. | |
| |_________________| |
|  ___ ___ ___   ___  |
| | 7 | 8 | 9 | | + | |
| |___|___|___| |___| |
| | 4 | 5 | 6 | | - | |
| |___|___|___| |___| |
| | 1 | 2 | 3 | | x | |
| |___|___|___| |___| |
| | . | 0 | = | | / | |
| |___|___|___| |___| |
|_____________________|
'

echo "Oh yeah, it's big brain time !"
echo ''

function readinput {
    read -p 'Give me your first number : ' NUM1
    read -p 'Give me your operand : ' OP
    read -p 'Give me your second number : ' NUM2
}


function checkinput {
    # Check if the first input is a whole number
    if ! [[ $NUM1 =~ ^[0-9]+$ ]]; then
        echo ''
        echo "Damn, I need a whole number, anything else won't work."
        return 1
    fi

    # Check if the operand is valid
    if [[ ! $OP =~ ^[\+\-\*\/]$ ]]; then
        echo ''
        echo "Wrong operand. I accept only +, -, *, and / my man."
        return 1
    fi

    # Check if the second input is a whole number
    if ! [[ $NUM2 =~ ^[0-9]+$ ]]; then
        echo ''
        echo "Damn, I need a whole number, anything else won't work."
        return 1
    fi

    return 0
}

function wronginput {
    echo ''
    echo 'Ahoy mate, there was something wrong in everything you gave me. Try again.'
    echo ''
    return 1
}

readinput
checkinput

while [[ $? -ne 0 ]]; do
    readinput
    checkinput
done

# Calculus boy
echo 'The result is ' $(($NUM1 $OP $NUM2))
echo ''
echo 'See you later, sympathetic boy !'

exit 0