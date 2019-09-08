#!/bin/bash
# script creation : 
# 1/ go to project folder
# 2/ touch create-page.sh
# 3/ chmod +x create-page.sh
# 4/ alias create-page='./create-page.sh'
# 5/ copy paste same below content
# script launch : 
# create-page -feature feature -page page -components CA CB
# create-page -feature users -page UsersListPage -components UserList UserListRow
# $1 : -feature
# $2 : users
# $3 : -page
# $4 : UsersListPage

if [ "$1" = "" -o "$1" != "-feature" ] 
then 
  echo "Command syntax error (-feature) :
    syntaxe : create-page -feature feature -page page -components CA CB
    example : create-page -feature users -page UsersListPage -components UserList UserListRow"
  exit -1;
fi

if [ "$2" = "" ] 
then 
  echo "Feature name is mandatory :
    syntaxe : create-page -feature feature -page page -components CA CB
    example : create-page -feature users -page UsersListPage -components UserList UserListRow"
  exit -1;
fi

if [ "$3" = "" -o "$3" != "-page" ] 
then 
  echo "Command syntax error (-page) :
    syntaxe : create-page -feature feature -page page -components CA CB
    example : create-page -feature users -page UsersListPage -components UserList UserListRow"
  exit -1;
fi

if [ "$4" = "" ] 
then 
  echo "Page name is mandatory :
    syntaxe : create-page -feature feature -page page -components CA CB
    example : create-page -feature users -page UsersListPage -components UserList UserListRow"
  exit -1;
fi

# if feature no exist create it
./scripts/create-feature.sh $2

# paths
srcPagePath="front-js/js/features/$2/pages"
srcComponentsPath="front-js/js/features/$2/components"
srcRoutesPath="front-js/js/Routes.js"
componentsPath="../components"

# create empty page
pageName=$4.jsx
pagePath=${srcPagePath}/${pageName};
touch ${pagePath}

# $5 : -components
# $6-n : components
#  optionals
if [ "$5" != "" -a "$5" != "-components" ] 
then 
  echo "Command syntax error (-components) :
    syntaxe : create-page -feature feature -page page -components CA CB
    example : create-page -feature users -page UsersListPage -components UserList UserListRow"
  exit -1;
fi

if [ "$5" != "" -a "$5" = "-components" -a "$6" = "" ] 
then 
  echo "You should add at least one component :
    syntaxe : create-page -feature feature -page page -components CA CB
    example : create-page -feature users -page UsersListPage -components UserList UserListRow"
  exit -1;
fi

# create components
# path relative to page
pageComponentsImport=""
pageComponentsRender=""
if [ "$5" != "" -a "$5" = "-components" -a "$6" != "" ] 
then 
  argc=$#
  argv=($@)
  for (( j=5; j<argc; j++ )); do
    fileName=${srcComponentsPath}/${argv[j]}.jsx
    testFileName=${srcComponentsPath}/${argv[j]}-test.jsx
    touch ${fileName}
    touch ${testFileName}
    pageComponentsImport+="\nimport ${argv[j]} from '${componentsPath}/${argv[j]}';"
    pageComponentsRender+="\n        <${argv[j]}
          loading={loading}
          data={data}
          error={error}
          onClick={item => this.customOnItemClick(item)}
        />"
    componentStructure="
import React, { Fragment } from 'react';
import PropTypes from 'prop-types';

// functional & stateless component
const ${argv[j]} = ({
  loading,
  error,
  data,
  onClick,
}) => {
  console.log('${argv[j]} loading : ', loading);
  console.log('${argv[j]} error : ', error);
  console.log('${argv[j]} data : ', data);

  // loading status
  if (loading) {
    // display loader
  }

  // error status
  if (error) {
    // display error notification
  }

  // render only if data
  return (
    <Fragment>
      <div>${argv[j]}</div>
      <button type=\"button\" onClick={() => onClick()}>ClickMe</button>
    </Fragment>
  );
};

// prop types validation
${argv[j]}.propTypes = {
  data: PropTypes.arrayOf(PropTypes.shape({
    // define data structure
  })),
  error: PropTypes.shape({
    // define error structure
  }),
  loading: PropTypes.bool,
  onClick: PropTypes.func,
};

// default props
${argv[j]}.defaultProps = {
  data: null,
  error: null,
  loading: false,
  onClick: null,
};

export default ${argv[j]};
"
    echo -n -e "${componentStructure}" > ${fileName}
  done
fi


# page structure
pageAPIImport="
import React, { Component, Fragment } from 'react';
import PropTypes from 'prop-types';"

pageStructure="
class $4 extends Component {
  // propsType (validation)
  static propTypes = {};

  // default props
  static defaultProps = {};

  // initial state
  state = {};

  // did mount staff
  componentDidMount() { }

  // custom actions
  // on user click action
  customOnItemClick = item => {
    console.log('customOnItemClick item: ', item);
    if (item) {
      // staff when item clicked
    }
  };
"

pageRender="
  // render
  render() {
    // replace this part with
    // props destructing :
    // const { data, error, loading} = this.props
    const data = null;
    const error = null;
    const loading = false;
    return (
      <Fragment>
        <span>$4</span>${pageComponentsRender}
      </Fragment>
    );
  }
}
"

pageExport="export default $4;\n"
echo -n -e "${pageAPIImport}\n${pageComponentsImport}\n${pageStructure}\n${pageRender}\n${pageExport}" > ${pagePath}

# add page to Routes.js if not exist
if grep -q -n $4 "${srcRoutesPath}"
then 
  echo "Page $4 Created Successfully (route exist)"
  exit -1;
fi

newRoute="      <Route exact path=\"/$4\" component={$4} />"
routerLinesCount=$(cat ./${srcRoutesPath} | wc -l)
routerSwitchLine=$(grep -n '<Switch>' ${srcRoutesPath}| cut -f1 -d: | tail -1) 

# retreive part from begin to switch
initRouteParts=$(head -n${routerSwitchLine} ${srcRoutesPath})

# retreive part from after swith to end
routesParts=$(awk "NR>${routerSwitchLine}&&NR<=${routerLinesCount}" ${srcRoutesPath})

# assemble parts : part befor switch + new route + part after switch
echo -n -e "${initRouteParts}\n${newRoute}\n${routesParts}\n" > ${srcRoutesPath}

# add the new import
routerLinesCount=$(cat ./${srcRoutesPath} | wc -l)
lastImportLine=$(grep -n 'import' ${srcRoutesPath} | cut -f1 -d: | tail -1) 
routerImportParts=$(head -n${lastImportLine} ${srcRoutesPath})
newImport="import $4 from './$2/pages/$4';"
codeParts=$(awk "NR>${lastImportLine}&&NR<=${routerLinesCount}" ${srcRoutesPath})

# assemble parts : old imports + new Import + code parts
echo -n -e "${routerImportParts}\n${newImport}\n${codeParts}\n" > ${srcRoutesPath}

echo "Page $4 Created Successfully"
