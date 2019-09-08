#!/bin/bash
# script creation : 
# 1/ go to project folder
# 2/ touch project-init-with-redux-saga.sh
# 3/ chmod +x project-init-with-redux-saga.sh
# 4/ alias project-init-with-redux-saga='./project-init-with-redux-saga.sh'
# 5/ copy paste same below content
# script launch : 
# project-init-with-redux-saga

echo "project init with redux start"

echo "install dependencies"
npm install redux react-redux redux-saga -d --save

echo "add redux HOCs"
mkdir -p src/commons/redux

mkdir temp

git clone https://github.com/helabenkhalfallah/redux-saga-cli-lib.git temp

cp temp/* src/commons/redux

rm -rf temp

echo "init redux"

newImport="import withReduxBoot from './commons/redux/withReduxBoot';"

newExport="export default withReduxBoot(Routes);"

lastImportLine=$(grep -n 'import' src/Routes.js | cut -f1 -d: | tail -1) 

linesCount=$(cat ./src/Routes.js | wc -l)

importParts=$(head -n${lastImportLine} src/Routes.js)

codeParts=$(awk "NR>${lastImportLine}&&NR<${linesCount}" src/Routes.js)

echo -n -e "${importParts}\n${newImport}\n${codeParts}\n${newExport}\n" > src/Routes.js

echo "project init with redux end"