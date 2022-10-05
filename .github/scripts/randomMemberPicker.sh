#!/bin/bash
# read list of current team members
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
membersfile="${DIR}/teamMembers.txt"
n=1
while read -r line; do
# reading each line
MEMBERS[$n]=$line
n=$((n+1))
done < $membersfile

# pull random integer between 1 and # of team members from atmospheric noise random number generator to make Will happier
i=$(curl "https://www.random.org/integers/?format=plain&num=1&min=1&max=${#MEMBERS[@]}&col=1&base=10&frnd=new")
res=$?
# falls back to shell random generator in case curl fails (res not 0)
if test "$res" != "0" 
then
   echo "the curl command failed with: $res"
   i=$(shuf -i 1-${#MEMBERS[@]} -n 1)
fi

echo "::set-output name=FACILITATOR::${MEMBERS[$i]}"
