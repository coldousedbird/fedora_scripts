# script for stabbing disc D with data

#!/bin/bash
blkid_output=$(sudo blkid)

printf "hi there. you tryin to automount some partition. which one?\n\n"

printf "$blkid_output"
printf "\n\ninput device name (like /dev/sda2) >>> "
read device

# Find the line containing LABEL="data" in the output of sudo blkid
data_line=$(echo "$blkid_output" | grep -Eo "$device:.*")

if [ -n "$data_line" ]; then
    # Extract UUID, TYPE, and PARTUUID from the data line
    uuid=$(echo "$data_line" | grep -o ' UUID="[^"]*' | cut -d'"' -f2)
    type=$(echo "$data_line" | grep -o ' TYPE="[^"]*' | cut -d'"' -f2)
    label=$(echo "$data_line" | grep -o ' LABEL="[^"]*' | cut -d'"' -f2)
    mount=$(echo "/run/media/$USER/$label")    

    # Generate the new line to be added to /etc/fstab
    new_line="UUID=$uuid $mount  $type  defaults  0  2"
    
    # Append the new line to /etc/fstab
    echo "$new_line" | sudo tee -a /etc/fstab > /dev/null
    printf "\nNew line added to /etc/fstab:\n$new_line"
    
    # mount disk
    sudo systemctl daemon-reload   

    # Create symlinks from home to directories in 
    path="/home/$USER"    
    rm -r $path/Documents
    ln -s $mount/Documents $path
    rm -r $path/Downloads
    ln -s $mount/Downloads $path
    rm -r $path/Games
    ln -s $mount/Games $path
    rm -r $path/Music
    ln -s $mount/Music $path
    rm -r $path/Pictures
    ln -s $mount/Pictures $path
    rm -r $path/Programming
    ln -s $mount/Programming $path
    rm -r $path/Videos
    ln -s $mount/Videos $path
    ln -s $mount $path

else
    printf "\nwell, couldn't find device, think again"
fi

printf "\n"


