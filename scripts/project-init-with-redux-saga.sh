#!/bin/bash
# script launch : 
# project-init-with-redux-saga

# paths
corePath="../../js/core"
featureCommonsPath="../../js/features/commons"
reduxPackageName="redux"
reduxCorePath=${corePath}/${reduxPackageName}
reduxCommonsPath=${featureCommonsPath}/${reduxPackageName}
srcRoutesPath="../../js/Routes.jsx"

echo "project init with redux start"

echo "install dependencies"
npm install redux react-redux redux-saga -d --save

echo "add redux HOCs"
mkdir -p ${reduxCorePath}
mkdir -p ${reduxCommonsPath}
mkdir temp

git clone https://github.com/helabenkhalfallah/redux-saga-cli-lib.git temp

cp temp/withReduxBoot.jsx ${reduxCorePath}
cp temp/withRedux.js ${reduxCorePath}
cp temp/AppReduxStore.js ${reduxCorePath}
cp temp/AppReduxReducers.js ${reduxCorePath}

cp temp/SagaRoot.js ${reduxCommonsPath}
cp temp/ReducerRoot.js ${reduxCommonsPath}

rm -rf temp

echo "init redux"

newImport="import withReduxBoot from './core/redux/withReduxBoot';"

newExport="export default withReduxBoot(Routes);"

lastImportLine=$(grep -n 'import' ${srcRoutesPath} | cut -f1 -d: | tail -1) 

linesCount=$(cat ./${srcRoutesPath} | wc -l)

importParts=$(head -n${lastImportLine} ${srcRoutesPath})

codeParts=$(awk "NR>${lastImportLine}&&NR<${linesCount}" ${srcRoutesPath})

echo -n -e "${importParts}\n${newImport}\n${codeParts}\n${newExport}\n" > ${srcRoutesPath}

echo "project init with redux end"