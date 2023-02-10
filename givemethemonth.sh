#!/bin/bash
# Give me the month !
# Made by Romain Ranaivoson
# Last update: 2023-02-10
# -------------------------------------------
# To use this script, either run ./start.sh before
# or run ./givemethemonth.sh with an argument
# No Windows here sorry boy
# -------------------------------------------

### Variable
STARTMETHOD=0
NB=0
SENTENCE='The month you are looking for is '

# Find if file is started via start or by file
pgrep start.sh
if [[ $? == 0 ]]; then
    STARTMETHOD=1
fi

echo '   .------\ /------.
   |       -       |
   |               |
   |               |
   |               |
_______________________
===========.===========
  / ~~~~~     ~~~~~ \
 /|     |     |\
 W   ---  / \  ---   W
 \.      |o o|      ./
  |                 |
  \    #########    /
   \  ## ----- ##  /
    \##         ##/
     \_____v_____/
'

echo 'Welcome ! I am the month giver'
echo ''

if [[ $STARTMETHOD == 0 ]]; then
    NB=$1
else
    read -p 'Give me a number, and I will give you the month : ' NB
fi

while [[ ! $NB =~ ^(0?[1-9]|1[0-2])$ ]]; do
    echo ''
    echo 'You monster ! You should give me a number between 1 and 12 instead of making fun of me !'
    read -p 'Give me a number, and I will give you the month : ' NB
    echo ''
done

#Corresponding month list
if [[ $NB == 1 ]]; then
    echo $SENTENCE January
fi
if [[ $NB == 2 ]]; then
    echo $SENTENCE February
fi
if [[ $NB == 3 ]]; then
    echo $SENTENCE March
fi
if [[ $NB == 4 ]]; then
    echo $SENTENCE April
fi
if [[ $NB == 5 ]]; then
    echo $SENTENCE May
fi
if [[ $NB == 6 ]]; then
    echo $SENTENCE June
fi
if [[ $NB == 7 ]]; then
    echo $SENTENCE July
fi
if [[ $NB == 8 ]]; then
    echo $SENTENCE August
fi
if [[ $NB == 9 ]]; then
    echo $SENTENCE September
fi
if [[ $NB == 10 ]]; then
    echo $SENTENCE October
fi
if [[ $NB == 11 ]]; then
    echo $SENTENCE November
fi
if [[ $NB == 12 ]]; then
    echo $SENTENCE December
fi

exit 0