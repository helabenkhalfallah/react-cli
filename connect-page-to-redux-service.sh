#!/bin/bash
# script launch :
# connect-page-to-redux-service -feature feature -page page -service service -service-data service-data -query-type post/get -query-params object-name  
# connect-page-to-redux-service -feature users -page UserListPage -service UserList -service-data users -query-type get
# connect-page-to-redux-service -feature users -page UserAddPage -service UserAdd -service-data user -query-type post -query-params user
# mandatory args :
# $1 : -feature
# $2 : feature name
# $3 : -page
# $4 : page name
# $5 : -service
# $6 : service name
# $7 : -service-data
# $8 : service-data
# $9 : -query-type
# $10 : post ou get => if get requestServiceName, if post submitServiceName
# $11 : -query-params
# $12: user

# projet file path
srcPath="../../js/features"
commonsPath=$(echo "${srcPath}/commons")
reduxApiPath=$(echo "${commonsPath}/redux")
reducerRootFile=$(echo "${reduxApiPath}/ReducerRoot.js")
sagaRootFile=$(echo "${reduxApiPath}/SagaRoot.js")
featureRelativeReduxApiPath="../../$2"

# feature check
if [ "$1" = "" -o "$1" != "-feature" ] 
then 
  echo "Command syntax error (-feature) :
    syntaxe : connect-page-to-redux-service -feature feature -page page -service service -service-data service-data -query-type post/get -query-params object-name 
    example (get) : connect-page-to-redux-service -feature users -page UserListPage -service UserList -service-data users -query-type get
    example (post) : connect-page-to-redux-service -feature users -page UserAddPage -service UserAdd -service-data user -query-type post -query-params user"
  exit -1;
fi

if [ "$2" = "" ] 
then 
  echo "Feature name is mandatory :
    syntaxe : connect-page-to-redux-service -feature feature -page page -service service -service-data service-data -query-type post/get -query-params object-name 
    example (get) : connect-page-to-redux-service -feature users -page UserListPage -service UserList -service-data users -query-type get
    example (post) : connect-page-to-redux-service -feature users -page UserAddPage -service UserAdd -service-data user -query-type post -query-params user"
  exit -1;
fi

# check if feature exist
featurePath=$srcPath/$2
if [ -d $featurePath ] 
then 
    echo "- Feature name ($2)"
else
    echo "Feature ($2) doesn't exist"
    exit -1;
fi

# page check
if [ "$3" = "" -o "$3" != "-page" ] 
then 
  echo "Command syntax error (-page) :
    syntaxe : connect-page-to-redux-service -feature feature -page page -service service -service-data service-data -query-type post/get -query-params object-name 
    example (get) : connect-page-to-redux-service -feature users -page UserListPage -service UserList -service-data users -query-type get
    example (post) : connect-page-to-redux-service -feature users -page UserAddPage -service UserAdd -service-data user -query-type post -query-params user"
  exit -1;
fi

if [ "$4" = "" ] 
then 
  echo "Page name is mandatory :
    syntaxe : connect-page-to-redux-service -feature feature -page page -service service -service-data service-data -query-type post/get -query-params object-name 
    example (get) : connect-page-to-redux-service -feature users -page UserListPage -service UserList -service-data users -query-type get
    example (post) : connect-page-to-redux-service -feature users -page UserAddPage -service UserAdd -service-data user -query-type post -query-params user"
  exit -1;
fi

# check if page exist
pagePath=$featurePath/pages/$4.jsx
if [ -f $pagePath ] 
then 
    echo "- Page name ($4)"
else
    echo "Page ($4) doesn't exist"
    exit -1;
fi

# service name should not contains space
# if service name contains space then
# -service-data check will fail
# service check
if [ "$5" = "" -o "$5" != "-service" ] 
then 
  echo "Command syntax error (-service) :
    syntaxe : connect-page-to-redux-service -feature feature -page page -service service -service-data service-data -query-type post/get -query-params object-name 
    example (get) : connect-page-to-redux-service -feature users -page UserListPage -service UserList -service-data users -query-type get
    example (post) : connect-page-to-redux-service -feature users -page UserAddPage -service UserAdd -service-data user -query-type post -query-params user"
  exit -1;
fi

if [ "$6" = "" ] 
then 
  echo "Service name is mandatory :
    syntaxe : connect-page-to-redux-service -feature feature -page page -service service -service-data service-data -query-type post/get -query-params object-name 
    example (get) : connect-page-to-redux-service -feature users -page UserListPage -service UserList -service-data users -query-type get
    example (post) : connect-page-to-redux-service -feature users -page UserAddPage -service UserAdd -service-data user -query-type post -query-params user"
  exit -1;
fi

# -service-data check
if [ "$7" = "" -o "$7" != "-service-data" ] 
then 
  echo "Command syntax error (-service-data) :
    syntaxe : connect-page-to-redux-service -feature feature -page page -service service -service-data service-data -query-type post/get -query-params object-name 
    example (get) : connect-page-to-redux-service -feature users -page UserListPage -service UserList -service-data users -query-type get
    example (post) : connect-page-to-redux-service -feature users -page UserAddPage -service UserAdd -service-data user -query-type post -query-params user"
  exit -1;
fi

if [ "$8" = "" ] 
then 
  echo "Service data is mandatory :
    syntaxe : connect-page-to-redux-service -feature feature -page page -service service -service-data service-data -query-type post/get -query-params object-name 
    example (get) : connect-page-to-redux-service -feature users -page UserListPage -service UserList -service-data users -query-type get
    example (post) : connect-page-to-redux-service -feature users -page UserAddPage -service UserAdd -service-data user -query-type post -query-params user"
  exit -1;
fi

# query type check
if [ "$9" = "" -o "$9" != "-query-type" ] 
then 
  echo "Command syntax error (-query-type) :
    syntaxe : connect-page-to-redux-service -feature feature -page page -service service -service-data service-data -query-type post/get -query-params object-name 
    example (get) : connect-page-to-redux-service -feature users -page UserListPage -service UserList -service-data users -query-type get
    example (post) : connect-page-to-redux-service -feature users -page UserAddPage -service UserAdd -service-data user -query-type post -query-params user"
  exit -1;
fi

if [ "${10}" = "" ] 
then 
  echo "Query type is mandatory :
    syntaxe : connect-page-to-redux-service -feature feature -page page -service service -service-data service-data -query-type post/get -query-params object-name 
    example (get) : connect-page-to-redux-service -feature users -page UserListPage -service UserList -service-data users -query-type get
    example (post) : connect-page-to-redux-service -feature users -page UserAddPage -service UserAdd -service-data user -query-type post -query-params user"
  exit -1;
fi

if [ "${10}" = "get" -o "${10}" = "post" ] 
then 
  echo "- Query Type (${10})"
else
  echo "Query type value can be get or post only (${10}) :
    syntaxe : connect-page-to-redux-service -feature feature -page page -service service -service-data service-data -query-type post/get -query-params object-name 
    example (get) : connect-page-to-redux-service -feature users -page UserListPage -service UserList -service-data users -query-type get
    example (post) : connect-page-to-redux-service -feature users -page UserAddPage -service UserAdd -service-data user -query-type post -query-params user"
  exit -1;
fi

# at this level we are sure
# that mandatory args are inputed,
# feature exist and page exist.
# create services folder if not exist
servicesPath=$srcPath/$2/services
mkdir -p $servicesPath

# create redux folder if not exist
reduxPath=$srcPath/$2/redux
mkdir -p $reduxPath
mkdir -p $reduxPath/reducers
mkdir -p $reduxPath/actions

# using (service name $6)
# upper case service name first
# char for file name pattern
serviceFirstChar=`echo $6|cut -c1|tr [a-z] [A-Z]`
serviceRestChar=`echo $6|cut -c2-`
serviceName=$(echo ${serviceFirstChar}${serviceRestChar})

# create reducer file inside redux if not exist
reducerClassName=$(echo "${serviceName}Reducer")

# add new reducer to root file only if not exist
canAddReducer="false"
grep -q "${reducerClassName}" $reducerRootFile; [ $? -eq 0 ] && canAddReducer="false" || canAddReducer="true"
if [ "${canAddReducer}" = "false" ] 
then 
    echo "Reducer ${reducerClassName} already exist on ReducerRoot" 
    exit -1;
fi

# check if Reducer file not exist
reducerFileName=$(echo ${reduxPath}/reducers/${reducerClassName}.js)
if [ -f $reducerFileName ] 
then 
    canCreateReducer="false"
else
    canCreateReducer="true"
    touch $reducerFileName
fi

# create action types file inside redux if not exist
actionTypesClassName=$(echo ${serviceName}ActionTypes)
actionTypesFileName=$(echo ${reduxPath}/actions/${actionTypesClassName}.js)
if [ -f $actionTypesFileName ] 
then 
    canCreateAction="false"
else
    canCreateAction="true"
    touch $actionTypesFileName
fi

# create service file inside service if not exist
serviceClassName=$(echo ${serviceName}Service)
serviceFileName=$(echo ${servicesPath}/${serviceClassName}.js)
if [ -f $serviceFileName ] 
then 
    canCreateService="false"
else
    canCreateService="true"
    touch $serviceFileName
fi

# check if we can fill files
if [ "${canCreateReducer}" = "false" ] 
then 
    echo "Reducer with same name already exist (${reducerFileName})"
    exit -1;
fi
if [ "${canCreateAction}" = "false" ] 
then 
    echo "Action Type with same name already exist (${actionTypesFileName})"
    exit -1;
fi
if [ "${canCreateService}" = "false" ] 
then 
    echo "Service with same name already exist (${serviceFileName})"
    exit -1;
fi

# we fill file with content
# only if service, reduce and action
# with same name doesn't exist
# to avoid existing files override
# fill file with content
# service-data is the props
# that will be inject to page,
# returned by the reducer and
# returned by the service
# action
# upper case all service name
# to match constant pattern
actionConstantName=$(echo "${serviceName}" | tr a-z A-Z)
actionTypesFileContent="const ${actionConstantName}_REQUEST = '${actionConstantName}_REQUEST';
const ${actionConstantName}_SUCCESS = '${actionConstantName}_SUCCESS';
const ${actionConstantName}_FAILURE = '${actionConstantName}_FAILURE';

// export actions types
const ${actionTypesClassName} = {
  ${actionConstantName}_REQUEST,
  ${actionConstantName}_SUCCESS,
  ${actionConstantName}_FAILURE,
};

export default ${actionTypesClassName};
"

echo -n -e "${actionTypesFileContent}" > ${actionTypesFileName}

# reducer
serviceData=$(echo "$8")
reducerFileContent="import ${actionTypesClassName} from '../actions/${actionTypesClassName}';

// reducer with initial state
const initialState = {
  loading: false,
  ${serviceData}: null,
  error: null,
};

// ${serviceName} reducer
const ${reducerClassName} = (state = initialState, action) => {
  console.log('${reducerClassName} action :', action);
  let newState = state;
  switch (action.type) {
    case ${actionTypesClassName}.${actionConstantName}_REQUEST:
      newState = {
        ...state,
        loading: true,
        error: null,
      };
      break;
    case ${actionTypesClassName}.${actionConstantName}_SUCCESS:
      newState = {
        ...state,
        loading: false,
        ${serviceData}: action.${serviceData},
      };
      break;
    case ${actionTypesClassName}.${actionConstantName}_FAILURE:
      newState = {
        ...state,
        loading: false,
        ${serviceData}: null,
        error: action.error,
      };
      break;
    default:
      newState = state;
  }

  console.log('${reducerClassName} newState :', newState);
  return newState;
};

export default ${reducerClassName};
"
echo -n -e "${reducerFileContent}" > ${reducerFileName}

# add reducer to Reducer Root

# count import
# extract import part
# extract code part (from last import line to file end)
# add new reducer import
# assemble file parts
reducerLinesCount=$(cat $reducerRootFile | wc -l)
reducerLastImportLine=1
reducerImportParts=""
if grep -q -n 'import' $reducerRootFile
then 
   reducerLastImportLine=$(grep -n 'import' $reducerRootFile | cut -f1 -d: | tail -1)
   reducerImportParts=$(head -n${reducerLastImportLine} $reducerRootFile)
   reducerCodeParts=$(awk "NR>${reducerLastImportLine}&&NR<=${reducerLinesCount}" $reducerRootFile)
else
   reducerCodeParts=$(awk "NR>=${reducerLastImportLine}&&NR<=${reducerLinesCount}" $reducerRootFile)
fi

reducerNewImport="import ${reducerClassName} from '${featureRelativeReduxApiPath}/redux/reducers/${reducerClassName}';"
echo -n -e "${reducerImportParts}\n${reducerNewImport}\n${reducerCodeParts}\n" > ${reducerRootFile}

# add new reducer at end of reducer queue
reducerLinesCount=$(cat $reducerRootFile | wc -l)
reducerModulesDeclarationLine=""
if grep -q -n "\];" $reducerRootFile 
then 
   reducerModulesDeclarationLine=$(grep -n "\];" $reducerRootFile | cut -f1 -d: | tail -1)
else
   echo "Reducer root module definition error (const ReducerRoot = [];)"
   exit -1; 
fi

reducerModuleDeclarationParts=$(awk "NR>=0&&NR<${reducerModulesDeclarationLine}" $reducerRootFile)
reducerModuleCodeParts=$(awk "NR>=${reducerModulesDeclarationLine}&&NR<=${reducerLinesCount}" $reducerRootFile)
reducerNewReducer="  ${serviceName}:${reducerClassName},"
echo -n -e "${reducerModuleDeclarationParts}\n${reducerNewReducer}\n${reducerModuleCodeParts}\n" > ${reducerRootFile}

# add service to Saga Root
# add new import to Saga Root
serviceRootLinesCount=$(cat $sagaRootFile | wc -l)
serviceRootLastImportLine=1
serviceRootImportParts=""
if grep -q -n 'import' $sagaRootFile
then 
   serviceRootLastImportLine=$(grep -n 'import' $sagaRootFile | cut -f1 -d: | tail -1)
   serviceRootImportParts=$(head -n${serviceRootLastImportLine} $sagaRootFile)
   serviceRootCodeParts=$(awk "NR>${serviceRootLastImportLine}&&NR<=${serviceRootLinesCount}" $sagaRootFile)
else
   serviceRootCodeParts=$(awk "NR>=${serviceRootLastImportLine}&&NR<=${serviceRootLinesCount}" $sagaRootFile)
fi

serviceRootNewImport="import ${serviceClassName} from '${featureRelativeReduxApiPath}/services/${serviceClassName}';"
actionRootNewImport="import ${actionTypesClassName} from '${featureRelativeReduxApiPath}/redux/actions/${actionTypesClassName}';"
echo -n -e "${serviceRootImportParts}\n${serviceRootNewImport}\n${actionRootNewImport}\n${serviceRootCodeParts}\n" > ${sagaRootFile}

# add service to yield Saga Root
serviceRootLinesCount=$(cat $sagaRootFile | wc -l)
serviceSagaFirstPart=""
serviceSagaEndPart=""
serviceSagaNewPart="    takeEvery(${actionTypesClassName}.${actionConstantName}_REQUEST, ${serviceClassName}),"
if grep -q -n 'yield all(\[' $sagaRootFile
then
   serviceSagaFirstPartLine=$(grep -n 'yield all(\[' $sagaRootFile | cut -f1 -d: | tail -1)
   serviceSagaFirstPart=$(head -n${serviceSagaFirstPartLine} $sagaRootFile)
   serviceSagaEndPart=$(awk "NR>${serviceSagaFirstPartLine}&&NR<=${serviceRootLinesCount}" $sagaRootFile)
else
   echo "Saga root module definition error (yield all([]);)"
   exit -1; 
fi

echo -n -e "${serviceSagaFirstPart}\n${serviceSagaNewPart}\n${serviceSagaEndPart}\n" > ${sagaRootFile}

# optional args
# disptach / mapstate to props
# state number
reducerLinesCount=$(cat $reducerRootFile | wc -l)
reducerModulesBeginDeclarationLine=""
reducerModulesEndDeclarationLine=""

# begin declaration
if grep -q -n "const ReducerRoot" $reducerRootFile 
then 
   reducerModulesBeginDeclarationLine=$(grep -n "const ReducerRoot" $reducerRootFile | cut -f1 -d: | tail -1)
else
   echo "Reducer root module definition error (const ReducerRoot = [];)"
   exit -1; 
fi

# end declaration
if grep -q -n "];" $reducerRootFile 
then 
   reducerModulesEndDeclarationLine=$(grep -n "\];" $reducerRootFile | cut -f1 -d: | tail -1)
else
   echo "Reducer root module definition error (const ReducerRoot = [];)"
   exit -1; 
fi

#reducer part
reducersCount=$(awk "NR>${reducerModulesBeginDeclarationLine}&&NR<${reducerModulesEndDeclarationLine}" $reducerRootFile | wc -l)
reducersCount=$((reducersCount-1))

# import actions & withRedux inside page
reducerPageImport=""
if grep -q -n "withRedux" $pagePath 
then 
reducerPageImport=""
else
reducerPageImport="
import withRedux from '../../commons/redux/withRedux';"
fi

if grep -q -n "${actionTypesClassName}" $pagePath 
then 
reducerPageImport+=""
else
reducerPageImport+="
import ${actionTypesClassName} from '../redux/actions/${actionTypesClassName}';"
fi

# mapStateToProps
reducerPageMapStateToProps="
const mapStateToProps = state => {
  const {
    ${serviceName}
  } = state;
  return {
    ${serviceData}: ${serviceName}.${serviceData},
    ${serviceData}Loading: ${serviceName}.loading,
    ${serviceData}Error: ${serviceName}.error,
  }
};
"

# mapDispatchToProps
reducerQueryName=""
if [ "${10}" = "get" ] 
then 
  reducerQueryName="request${serviceName}"
fi

if [ "${10}" = "post" ] 
then 
  reducerQueryName="submit${serviceName}"
fi

# $11 : -query-params
# $12 : objectName => action payload
reducerDispatch=""
if [ "${11}" = "-query-params" -a "${12}" != "" ] 
then 
  reducerDispatch=$(echo "${reducerQueryName}: ${12} => dispatch({ type: ${actionTypesClassName}.${actionConstantName}_REQUEST, payload: ${12} }),")
else
  reducerDispatch=$(echo "${reducerQueryName}: () => dispatch({ type: ${actionTypesClassName}.${actionConstantName}_REQUEST }),")
fi

reducerPageMapDispatchToProps="
const mapDispatchToProps = dispatch => ({
  ${reducerDispatch}
});
"

# connect
reducerPageConnect="export default withRedux(
  mapStateToProps,
  mapDispatchToProps,
  $4,
);"

# divide page
# get import part
pageLinesCount=$(grep -n 'export default' $pagePath | cut -f1 -d: | tail -1)
pageLastImportLine=1
pageImportParts=""
pageCodeParts=""

if grep -q -n 'import' $pagePath
then 
   pageLastImportLine=$(grep -n 'import' $pagePath | cut -f1 -d: | tail -1)
   pageImportParts=$(head -n${pageLastImportLine} $pagePath)
   pageCodeParts=$(awk "NR>${pageLastImportLine}&&NR<${pageLinesCount}" $pagePath)
else
   pageCodeParts=$(awk "NR>=${pageLastImportLine}&&NR<${pageLinesCount}" $pagePath)
fi

echo -n -e "${pageImportParts}\n${reducerPageImport}\n${pageCodeParts}\n${reducerPageMapStateToProps}\n${reducerPageMapDispatchToProps}\n${reducerPageConnect}\n" > ${pagePath}

# prepare service
# $9 : -query-type
# $10 : post ou get
sagaQueryType=""
if [ "${10}" = "get" ] 
then 
  sagaQueryType="axios.get"
else
  sagaQueryType="axios.post"
fi

sagaAction=""
if [ "${11}" = "-query-params" -a "${12}" != "" ] 
then 
  sagaAction="action"
else
  sagaAction=""
fi

requestParams=""
if [ "${sagaAction}" != "" ] 
then 
  requestParams="const params = ${sagaAction}.payload;"
else 
  requestParams="const params = null;"
fi

serviceContent="
import { call, put } from 'redux-saga/effects';
import axios from 'axios';
import ${actionTypesClassName} from '../redux/actions/${actionTypesClassName}';

// change with your service Path
const ${actionConstantName}_SERVICE_PATH = 'service path';

// service query
const query = (baseUrl, params) => {
  // correct url
  const url = 'baseUrl/${actionConstantName}_SERVICE_PATH';
  return ${sagaQueryType}(url, params);
};

// saga worker
export default function* ${reducerQueryName}(${sagaAction}) {
  try {
    // get action payload
    // remove if not need
    ${requestParams}

    // get base url
    const baseUrl = '';

    // execute query
    const response = yield call(query, baseUrl, params);
    console.log('${reducerQueryName} response : ', response);

    // parse response
    const { 
      error, 
      data: ${serviceData},
    } = ResponseFormatter(response);
    console.log('${reducerQueryName} error : ', error);
    console.log('${reducerQueryName} data : ', ${serviceData});

    // update reducer with request status
    if (error) {
      yield put({ type: ${actionTypesClassName}.${actionConstantName}_FAILURE, error });
    } else {
      yield put({ type: ${actionTypesClassName}.${actionConstantName}_SUCCESS, ${serviceData} });
    }
  } catch (error) {
    // update reducer with request status
    console.log('${reducerQueryName} exception error : ', error);
    yield put({ type: ${actionTypesClassName}.${actionConstantName}_FAILURE, error });
  }
}
"

echo -n -e "${serviceContent}" > ${serviceFileName}
