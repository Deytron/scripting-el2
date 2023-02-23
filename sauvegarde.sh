#!/bin/bash
# 10Pass
# Made by Romain Ranaivoson
# Last update: 2023-02-23
# -------------------------------------------
# To use this script, run ./sauvegarde.sh
# With arguments like -i or -s
# No Windows here sorry boy
# -------------------------------------------

### Variables
STARTMETHOD=0
INTER=0
SRC=''
DEST=''
ARCH=''
CANCEL=0
DATE=$(date +"%Y%m%dT-%H%M%S")
RETENTION=3

echo 'Script Sauvegarde'
echo

# Trap signals
trap getsig SIGINT
trap getsig SIGTERM
trap getsig HUP


# Check for -i
if [[ $1 == '-i' ]]; then
    INTER=1
fi

####### FUNCTIONS

# Echo syntax in case of error
function usage() {
    echo >&2 'Incorrect usage'
    echo >&2
    echo >&2 'Usage : ./sauvegarde.sh [-i] [-s <source> -d <dest>]'
    exit 1
}

function getsig() {
    echo
    echo 'Aborted !'
    echo 'Cancelling operation...'
    CANCEL=1
    exit 2
}

# Check number of saved files before saving
function checksaves() {
    N=$(ls -1q $DEST | wc -l)
    if [[ $N -gt 3 ]]; then
        echo 'Maximum save numbers reached'
        echo 'Deleting oldest archive....'
        ((N=N-2))
        for f in $(seq $N); do
            rm "$DEST/$(ls -t $DEST | tail -1)"
        done
    fi
}

# Actual save function
function save() {
    ARCH=$(echo "$DATE.tar.gz" | sed 's/\//_/g' | cut -c2-)
    FULL=$(echo "$DEST-$DATE.tar.gz" | sed 's/\//_/g' | cut -c2-)
    ARCHLOC=$(echo "$DEST/$DATE.tar.gz")
    checksaves
    echo
    echo "Saving to $DEST"
    tar -czvf "$DEST/$FULL" $SRC
    if [[ $CANCEL == 1 ]]; then
        rm $ARCH
    fi
}

function checkloc() {
    if [ -d "$SRC" ]; then
        echo "Source set to $SRC"
    else
        echo "Incorrect source location : $SRC"
        exit 1
    fi
    if [ -d "$DEST" ]; then
        echo "Destination set to $DEST"
    else
        echo "Incorrect destination location : $DEST"
        exit 1
    fi
    save
}

function interreadinput() {
     read -p "Input source directory : " SRC
        while true; do
            if [ -d "$SRC" ]; then
                echo "Source set to $SRC"
                break
            else
                echo "Incorrect location : $SRC"
            fi
        done
        read -p "Input destination directory : " DEST
        while true; do
            if [ -d "$DEST" ]; then
                echo "Destination set to $DEST"
                break
            else
                echo "Incorrect location : $DEST"
            fi
        done
}

# MAIN FUNCTION
if [[ $INTER != 1 ]]; then
    while getopts ":d:s:" o; do
        case "${o}" in
            s)
                s=${OPTARG}
                ;;
            d)
                d=${OPTARG}
                ;;
            *)
                usage
                ;;
        esac
    done
    else
        interreadinput
fi
shift $((OPTIND-1))
if [ -z "$s" ] || [ -z "$d" ]; then
        usage
else
    SRC=${s}
    DEST=${d}
    checkloc
fi