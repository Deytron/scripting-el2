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
INPUT='liste.csv'

echo 'Gestion utilisateurs'
echo

### FONCTIONS
function import_user() {
    while IFS=";" read -r c1 c2 c3 c4 c5
    do
        if grep -q "$c1.$c2" passwd;then
         echo "User $c1.$c2 already exists. Skipping..."
    else
        PASSWD=$(echo $RANDOM | md5sum | head -c 20 | mkpasswd -s)
        USERID=uuidgen
        echo "$c1.$c2:$PASSWD:$USERID:100:$c1$c2:/home/$c1.$c2:/bin/bash" >> passwd
        echo "Done creating user $c1 $c2"
    fi
    done < <(tail -n +2 $INPUT)
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
    echo "Usage : [--search-user] [--import-user FILE.csv] [--reset-password] [--help]"
    exit 1
}

# MAIN FUNCTION
if [ $# -eq 0 ]; then
    echo 'Error : no argument provided'
    exit 1
fi

# Get args and functions depending on
for arg in "$@"
do
    case $arg in
        --import-user)
            import_user
            ;;

        --search-user)
            search_user
            ;;

        --reset-password)
            reset_password
            ;;

        *.csv)
            INPUT="$arg"
        ;;

        *)
            usage
            ;;
    esac
done
