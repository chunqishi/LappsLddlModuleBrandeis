#!/bin/bash
###
##  A simple linux command line to run java class or testcase class.
#

CurDir=$(dirname $0)
CD=$(pwd)
cd $CurDir
HomeDir=$(dirname $CurDir)
LibDir=$HomeDir/lib
echo $LibDir
Jar=$(find $LibDir -type f -name 'LDDL*.jar')
echo $Jar
Version=${Jar%.*}
Version=${Version##*/}

Lddl=$1
if [[ -f $Lddl ]]; then

echo
echo "Running $Version ..."
echo "<------------ $Lddl ------------------"
java -jar $Jar $Lddl
errno=$?
echo "--------------------------------------->"

if [ $errno -eq 0 ]; then
    echo "LDDL Succeeded !"
    echo
else
    echo "Edit ( Press [Enter] to continue ) ..."
    read keypress
    vim $Lddl

fi

else
  echo "LDDL $Lddl not exist. "
  find $CurDir -name "*.lddl"
fi

cd $CD