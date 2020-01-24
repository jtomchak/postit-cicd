#!/bin/bash
#A very basic time counting script.
#init value of x
x=1
#make y 1 less than x
y=$((x-1))
echo "Counting from $y..." #Output what number we are beginning from
while [ $x -le 10 ] #While $x is >= 0 (all the time)
do
sleep 1 #Wait one second
echo "Now it's .... $x" #Echo value of $x
x=$((x+1)) #Increase $x by 1
done

# exit
exit 0