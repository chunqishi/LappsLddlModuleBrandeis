#!/bin/sh



Githubs="
https://github.com/chunqishi/edu.brandeis.cs.stanfordnlp-web-service.git
https://github.com/chunqishi/edu.brandeis.cs.opennlp-web-service.git
"
Tag='api2.0'

TOMCAT_SERVICES="/local/eldrad/users/lapps/tomcat/8282/"











${TOMCAT_SERVICES}/bin/shutdown.sh

curdir=${pwd}
for github in  ${Githubs}
do
    echo ${github}
    prodir=${github%%.git}
    prodir=${prodir##*/}
    if [ -r ${prodir} ]; then
       rm -rf ${prodir}
    fi
    git clone ${github}
    cd $prodir
    git checkout ${Tag}
    mvn clean package
    war=`find . -name *.war`
    if [ -f ${war} ]; then
        echo 'copy '${war}' to  '${TOMCAT_SERVICES}
        cp  ${war} ${TOMCAT_SERVICES}/webapps
    fi
    cd $curdir
done

${TOMCAT_SERVICES}/bin/startup.sh
