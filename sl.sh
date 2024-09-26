#!/bin/bash

# Ask the user for what they want

# List the options
echo "What option do you want to select"
echo "d: default version"
echo "a: An accident about to happen"
echo "l: Little train"
echo "F: Train flies"
echo "all: all effects one by one"

read -p "Enter your choice: " user_option
read -p "Do you want lolcat (rainbow effect) (y)es or (n)o: " lolcat_preferences

options=("d" "a" "l" "F" "all")

is_valid_option=false
is_gonna_lolcat=false

command="sl -e "

# Check if the user_option is valid
for option in "${options[@]}"
do
    if [ "$user_option" = "$option" ]; then
        is_valid_option=true
        break
    fi
done

if [ "$is_valid_option" = false ]; then
    echo "Not a valid option"
    exit 1
fi


if [[ "$lolcat_preferences" = "y" || "$lolcat_preferences" = "yes" ]]; then
    is_gonna_lolcat=true
fi

#clearing the terminal before running
clear

# Running the programs with user selected flags
if [[ $is_gonna_lolcat = true && ( "$user_option" = "a" || "$user_option" = "l" || "$user_option" = "F" ) ]]; then
    command+="-$user_option | lolcat"
elif [[ $is_gonna_lolcat = true && "$user_option" = "all" ]]; then
	#default version
	sl -e | lolcat
    for option in "a" "l" "F"
    do
        sl -e -$option | lolcat
    done
    exit 0
elif [[ $is_gonna_lolcat = true && "$user_option" = "d" ]]; then
    command+=" | lolcat"
fi

if [[ $is_gonna_lolcat = false && ( "$user_option" = "a" || "$user_option" = "l" || "$user_option" = "F" ) ]]; then
    command+="-$user_option"
elif [[ $is_gonna_lolcat = false && "$user_option" = "all" ]]; then
	#default version
	sl -e 
    for option in "a" "l" "F"
    do
        command="sl -$option -e"
        eval "$command"
    done
    exit 0
fi


eval "$command"
