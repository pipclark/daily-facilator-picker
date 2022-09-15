#!/bin/bash

# read list of current team members
filename="`dirname $0`"/'teamMembers.txt'
n=1
while read -r line; do
# reading each line
MEMBERS[$n]=$line
n=$((n+1))
done < $filename

# shuffle array
MEMBERS=( $(shuf -e "${MEMBERS[@]}") )

echo "${MEMBERS[0]}"
