#!/bin/bash
# BigDB
# Made by Romain Ranaivoson
# Last update: 2023-02-17
# -------------------------------------------
# To use this script, either run ./start.sh before
# or run ./bigdb.sh
# No Windows here sorry boy
# -------------------------------------------

### Variables
USERNAME=""
USERLIST=$(cat db.txt)
PASS=''
CURRPASS=''
EDITPASS=0

cat << "EOF"
                               _
                           ,--.\`-. __
                         _,.`. \:/,"  `-._
                     ,-*" _,.-;-*`-.+"*._ )
                    ( ,."* ,-" / `.  \.  `.
                   ,"   ,;"  ,"\../\  \:   \
                  (   ,"/   / \.,' :   ))  /
                   \  |/   / \.,'  /  // ,'
                    \_)\ ,' \.,'  (  / )/
                        `  \._,'   `"
                           \../
                           \../
                 ~        ~\../           ~~
          ~~          ~~   \../   ~~   ~      ~~
     ~~    ~   ~~  __...---\../-...__ ~~~     ~~
       ~~~~  ~_,--'        \../      `--.__ ~~    ~~
   ~~~  __,--'              `"             `--.__   ~~~
~~  ,--'                                         `--.
   '------......______             ______......------` ~~
 ~~~   ~    ~~      ~ `````---"""""  ~~   ~     ~~
        ~~~~    ~~  ~~~~       ~~~~~~  ~ ~~   ~~ ~~~  ~
     ~~   ~   ~~~     ~~~ ~         ~~       ~~  
              ~        ~~       ~~~       ~
EOF

echo 'BigDB'
echo ''
sleep 2

function init {
    if [ -f "./db.txt" ]; then
        echo "Found the database"
    else
        echo 'Creating database db.txt'
        touch db.txt
    fi
}

function checkchar {
    while [[ ! $USERNAME =~ [a-zA-Z]+ ]]; do
        echo ''
        read -p 'Please enter a proper username : ' USERNAME
    done
    checkuserexists
}

function newpass {
    read -p "Enter new password : " PASS
    checkpass
    SHAPASS=$(echo -n $PASS | sha256sum)
    if [[ $EDITPASS == 1 ]];then
        sed -i "s/$CURRPASS/$SHAPASS/" db.txt
    else
        echo $USERNAME: $SHAPASS >> db.txt
    fi
    alldone
}

function checkcurrpass {
    checkpass
    SHAPASSBIS=$(echo -n $PASS | sha256sum)
    while [[ "$CURRPASS" != "$SHAPASSBIS" ]]; do
        echo $SHAPASSBIS
        echo $CURRPASS
        echo ''
        read -p 'Wrong password. Try again : ' PASS
    done
    newpass
    EDITPASS=1
}

function checkpass {
    while [[ ! $PASS =~ [a-zA-Z]+ ]]; do
        echo ''
        echo 'You must be kidding me'
        read -p 'ENTER THE NEW PASSWORD : ' PASS
    done
}

function checkuserexists {
    if echo $USERLIST | grep -q $USERNAME; then
        echo ''
        echo "Found user $USERNAME. He exists !"
        echo ''
        CURRPASS=$(grep $USERNAME db.txt | sed 's/^.*: //') 
        read -p 'Please confirm the current password : ' PASS
        checkcurrpass
    else
        echo "Haven't seen your face around here."
        newpass
    fi
}

function alldone {
    echo ''
    echo "Looks like I'm all done here"
    echo "See you later $USERNAME!"
}

# Logic flow
init
read -p 'Search for a user, or enter a new username : ' USERNAME
checkchar


exit 0