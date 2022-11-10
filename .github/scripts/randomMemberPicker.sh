#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# read list of current team members
filename="${DIR}/teamMembers.txt"
n=1
while read -r line; do
# reading each line
MEMBERS[$n]=$line
n=$((n+1))
done < $filename

calander_path="${DIR}/AIMCalander.csv"
# check absences, passing in path to csv file, and pipe returned python array into bash array
absent=($(python3 ${DIR}/checkAbsences.py $calander_path 2>&1 | tr -d '[],'))

# remove single quotes from absent values
absent=(${absent[@]//\'/})
echo ${absent[@]}
# build new array without absent members
l=1
for m in ${MEMBERS[@]}; do
   if [[ ! " ${absent[*]} " =~ " $m " ]]; then
      PRESENT[$l]=$m
      l=$((l+1))
   fi
done
echo ${PRESENT[@]}

# pull random integer between 1 and # of team members from atmospheric noise random number generator to make Will happier
i=$(curl "https://www.random.org/integers/?format=plain&num=1&min=1&max=${#PRESENT[@]}&col=1&base=10&frnd=new")
res=$?
# falls back to shell random generator in case curl fails (res not 0)
if test "$res" != "0" 
then
   echo "the curl command failed with: $res"
   i=$(shuf -i 1-${#PRESENT[@]} -n 1)
fi

echo "FACILITATOR=${MEMBERS[$i]}" >> $GITHUB_OUTPUT