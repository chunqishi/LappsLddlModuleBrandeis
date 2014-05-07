#!/bin/bash
###
##  A simple linux command line to run java class or testcase class.
#

LDDL_GIT_HUB=https://github.com/ksuderman/org.anc.lapps.lddl

pushd `dirname $0` > /dev/null
CurDir=$(pwd -P)
popd > /dev/null
CD=$(pwd)

#cd $CurDir
HomeDir=$(dirname $CurDir)
LibDir=$HomeDir/lib
echo $LibDir
TmpDir=${HomeDir}/tmp

if [ ! -d ${TmpDir} ]; then
    mkdir ${TmpDir}
fi


echo
echo "Running Git ..."
echo "<------------ Git Clone ------------------"
git clone ${LDDL_GIT_HUB} ${TmpDir}/lddl
cd ${TmpDir}/lddl
#echo $(mvn clean package)
mvn clean package
cd ${CD}



echo "------------- Lib Update ------------------"
TIME=$(date '+%Y-%m-%d_%H-%M-%S')
cd "${LibDir}"
#rename .jar .jar.${TIME} "*.jar"

for file in "${LibDir}"/*.jar; do
    mv "$file" "$file.${TIME}"
done

cp "${TmpDir}"/lddl/target/*.jar "${LibDir}"
errno=$?
echo "------------------------------------------->"

if [ $errno -eq 0 ]; then
    echo "Update Succeeded !"
    echo
else
    echo "Edit ( Press [Enter] to continue ) ..."
    read keypress
fi

if [ -d ${TmpDir} ]; then
    rm -rf ${TmpDir}
fi