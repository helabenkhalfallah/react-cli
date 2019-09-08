#!/bin/bash
# script launch : 
# add-conf-var.sh -name varName -value varValue

# paths
confPath="../../conf"
confFiltersPath="${confPath}/filters"
dataFrontSrvPath="${confPath}/ressources/byenv/dataFrontSrv.properties"

# user inputs
varName=$2
varValue=$4
varLine="${varName}=${varValue}"
dataFrontSrvLine="${varName}=@${varName}@"

# update conf properties
for file in ${confFiltersPath}/*; do
    if grep -q -n $2 "${file}"
    then 
      echo "Variable $2 already exist ${file}"
    else
      echo -n -e "${varLine}\n" >> ${file}
    fi
done

# update dataSrv

# add variable if not exist
if grep -q -n $2 "${dataFrontSrvPath}"
then 
  echo "Variable $2 already exist (dataFrontSrv.properties)"
  exit -1;
else
  echo -n -e "${dataFrontSrvLine}\n" >> ${dataFrontSrvPath}
  exit -1;
fi


