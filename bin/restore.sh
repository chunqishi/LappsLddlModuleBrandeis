#!/usr/bin/env sh

#UserName=lapps
#DataBase=servicegrid
#DATE=$(date +%Y%m%d_%H%M%S)
BAK_SQL=$1


while [[ ! -f $BAK_SQL ]];
do
    read -p "Please input file: " BAK_SQL
done

while [[ $UserName == "" ]];
do
    read -p "Please input the UserName of database: " UserName
done

while [[ $DataBase == "" ]];
do
    read -p "Please input the Name of database: " DataBase
done


psql -U $UserName -d $DataBase -f $BAK_SQL

ErrNO=$?
echo $ErrNO
if [ $ErrNO -eq 0 ]; then
	echo "Dump $BAK_SQL has been restored into user $UserName's database '$DataBase'."
else
	echo "Restore Error !"
fi
