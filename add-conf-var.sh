#!/bin/bash
# script launch : 
# add-conf-var.sh -name varName -value varValue

# paths
confPath="../../../conf"
confFiltersPath="${confPath}/filters"
dataFrontSrvPath="${confPath}/ressources/byenv/dataFrontSrv.properties"
awtPagePath="../../../bff/src/main/webapp/WEB-INF/awt-page.jsp"

# user inputs
varName=$2
varValue=$4
varLine="${varName}=${varValue}"

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
dataFrontSrvLine="${varName}=@${varName}@"
if grep -q -n $2 "${dataFrontSrvPath}"
then 
  echo "Variable $2 already exist (dataFrontSrv.properties)"
  exit -1;
else
  echo -n -e "${dataFrontSrvLine}\n" >> ${dataFrontSrvPath}
fi

# update awtPage
awtPageLine="    ${varName}: '\${dataFrontBundle.getPropertyStr('${varName}')}',"
awtPageLinesCount=$(cat ./${awtPagePath} | wc -l)
optionsLine=$(grep -n 'var options = {' ${awtPagePath} | cut -f1 -d: | tail -1) 
awtPageHeadParts=$(head -n${optionsLine} ${awtPagePath})
awtPageFooterParts=$(awk "NR>${optionsLine}&&NR=${awtPageLinesCount}" ${awtPagePath})
echo "" > ${awtPagePath}
echo -n -e "${awtPageHeadParts}\n${awtPageLine}\n${awtPageFooterParts}" > ${awtPagePath}
