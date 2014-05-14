#!/bin/bash
###
##  A simple linux command line to run java class or testcase class.
#



pushd `dirname $0` > /dev/null
CurDir=$(pwd -P)
popd > /dev/null
CD=$(pwd)

#cd $CurDir
HomeDir=$(dirname $CurDir)
LibDir=$HomeDir/lib
#echo $LibDir
Jar=$(find $LibDir -type f -name '*.jar')
#echo $Jar
Version=${Jar%.*}
Version=${Version##*/}

Lddl=$1
if [[ -f $Lddl ]]; then

echo
echo "Running $Version ..."
echo "<------------ $Lddl ------------------"
java -jar $Jar $Lddl $2 $3 $4
errno=$?
echo "--------------------------------------->"

if [ $errno -eq 0 ]; then
    echo "LDDL Succeeded !"
    echo
else
    echo "Edit ( Press [Enter] to continue ) ..."
    read keypress
    vi $Lddl

fi

else
  echo ""
  echo "@usage:"
  echo "bin/lddl.sh Setup.lddl"
  echo ""
  echo "@refer:"
  echo "You can use one of the *.lddl:"
  echo "<------------ all lddls ------------------"
  find $HomeDir -name "*.lddl"
  echo "----------------------------------------->"
  echo ""
fi

#cd $CD