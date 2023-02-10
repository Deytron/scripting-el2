#!/bin/bash
# Filelight
# Made by Romain Ranaivoson
# Last update: 2023-02-10
# -------------------------------------------
# To use this script, either run ./start.sh before
# or run ./filelight.sh with an argument
# No Windows here sorry boy
# -------------------------------------------

### Variables
SIZE=""
FOLDER=""

echo '  ,-.
 _(*_*)_
(_  o  _)
  / o \
 (_/ \_)
'

echo 'Here comes the folder scanner !'
echo ''
echo 'Let me see...'
sleep 2

for d in /* ; do
    echo $d
    # Get the size of the directory in kilobytes
    size=$(du -s "$d" | awk '{print $1}')

    # If the size of this directory is larger than the maximum size,
    # update the maximum size and folder name
    if [[ $size -gt $SIZE ]]; then
        SIZE=$size
        FOLDER=$dir
    fi
done

# Convert to gigabyte
SIZE=$(echo "$folders_size" | sort -rh | head -1 | awk '{printf "%.2f\n", $1 / 1024 / 1024}')
echo "Found it ! The largest folder at the root of your system is $FOLDER with a size of $SIZE kilobytes."


exit 0