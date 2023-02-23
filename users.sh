#!/bin/bash
# Gestion users
# Made by Romain Ranaivoson
# Last update: 2023-02-23
# -------------------------------------------
# To use this script, run ./users.sh
# With arguments like -i or -s
# No Windows here sorry boy
# -------------------------------------------

### Variables
INPUT=''
DEFAULT='liste.csv'

echo 'Gestion utilisateurs'
echo

### FONCTIONS

function parsecsv() {
    echo 'parse'
}

function import_user() {
    echo 'éé'
}

function search_user() {
    echo 'éhtyé'
}

function reset_password() {
    echo 'eféé'
}

function usage() {
    echo 'Invalid arguments'
    echo
    echo "Usage : [--search-user] [--input-user FILE.csv] [--reset-password] [--help]"
    exit 1
}

# MAIN FUNCTION
if [ $# -eq 0 ]; then
    echo 'Error : no argument provided'
    exit 1
fi

# Get args
for arg in "$@"
do
    if [[ $arg == "*.csv" ]]; then
        INPUT=$arg
    fi
    case $arg in

        --import-user)
            if [[ $INPUT != '' ]];then
                INPUT=$DEFAULT
            fi
            import_user
            ;;

        --search-user)
            search_user
            ;;

        --reset-password)
            if [[ $arg != '' ]];then
                INPUT=$DEFAULT
            fi
            reset_password
            ;;

        *)
            usage
            ;;
        esac
done
