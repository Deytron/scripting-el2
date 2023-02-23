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
FOUND=0

echo 'Gestion utilisateurs'
echo

### FONCTIONS
function import_user() {
    while IFS=";" read -r c1 c2
    do
        if grep -q "$c1.$c2" passwd;then
         echo "User $c1.$c2 already exists. Skipping..."
    else
        PASSWD=$(echo $RANDOM | md5sum | head -c 20 | mkpasswd -s)
        USERID=$(echo uuidgen)
        echo "$c1.$c2:$PASSWD:$USERID:100:$c1$c2:/home/$c1.$c2:/bin/bash" >> passwd
        echo "Done creating user $c1 $c2"
    fi
    done < <(tail -n +2 $INPUT)
}


function search_user() {
    read -p "Which user are you searching for ? : " USER
    while [[ ! $USER =~ [a-zA-Z]+ ]]; do
        echo
        read -p 'Invalid user : ' USER
    done
    while IFS=";" read -r c1 c2
    do
        if grep -q "$USER" passwd;then
         echo "Users found corresponding to what you typed : "
         echo "$c1.$c2"
         FOUND=1
    fi
    done < <(tail -n +2 $INPUT)
     if [[ $FOUND == 0 ]]; then
        echo 'No user found'
    fi
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
