#!/usr/bin/env sh

UserName=lapps
DataBase=servicegrid

while [[ $UserName == "" ]];
do
    read -p "Please input the UserName of database: " UserName
done

while [[ $DataBase == "" ]];
do
    read -p "Please input the Name of database: " DataBase
done

DATE=$(date +%Y%m%d_%H%M%S)
BAK_SQL=$DataBase.$DATE.sql
pg_dump -U $UserName $DataBase -f $BAK_SQL

ErrNO=$?
if [ $ErrNO -eq 0 ]; then
	echo "User $UserName's database '$DataBase' has been dumped into $BAK_SQL ."
fi
