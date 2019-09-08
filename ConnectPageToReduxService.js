// npm run connect-page-to-redux-service feature feature-name page page-name service service-name service-data service-data-name query-type post/get query-params object-name
// npm run connect-page-to-redux-service feature users page UserListPage service UserList service-data users query-type get
// npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user
import shell from 'shelljs';

const args = process.argv;

// find feature name
// feature arg should be 'page'
if (args[2] !== 'feature') {
  shell.echo('Command syntaxe error (feature)');
  // eslint-disable-next-line max-len
  shell.echo('example (get) : npm run connect-page-to-redux-service feature users page UserListPage service UserList service-data users query-type get');
  // eslint-disable-next-line max-len
  shell.echo('example (post) : npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user');
  shell.exit(1);
}

if (args.length < 4) {
  // eslint-disable-next-line max-len
  shell.echo('(Feature name is mandatory example (get) : npm run connect-page-to-redux-service feature users page UserListPage service UserList service-data users query-type get');
  // eslint-disable-next-line max-len
  shell.echo('Feature name is mandatory example (post) : npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user');
  shell.exit(1);
}

// find page name
// page arg should be 'page'
if (args[4] !== 'page') {
  shell.echo('Command syntaxe error (page)');
  // eslint-disable-next-line max-len
  shell.echo('example (get) : npm run connect-page-to-redux-service feature users page UserListPage service UserList service-data users query-type get');
  // eslint-disable-next-line max-len
  shell.echo('example (post) : npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user');
  shell.exit(1);
}

if (args.length < 6) {
  // eslint-disable-next-line max-len
  shell.echo('(Page name is mandatory example (get) : npm run connect-page-to-redux-service feature users page UserListPage service UserList service-data users query-type get');
  // eslint-disable-next-line max-len
  shell.echo('Page name is mandatory example (post) : npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user');
  shell.exit(1);
}


// find service name
// service arg should be 'service'
if (args[6] !== 'service') {
  shell.echo('Command syntaxe error (service)');
  // eslint-disable-next-line max-len
  shell.echo('example (get) : npm run connect-page-to-redux-service feature users page UserListPage service UserList service-data users query-type get');
  // eslint-disable-next-line max-len
  shell.echo('example (post) : npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user');
  shell.exit(1);
}

if (args.length < 8) {
  // eslint-disable-next-line max-len
  shell.echo('(Service name is mandatory example (get) : npm run connect-page-to-redux-service feature users page UserListPage service UserList service-data users query-type get');
  // eslint-disable-next-line max-len
  shell.echo('Service name is mandatory example (post) : npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user');
  shell.exit(1);
}

// find service-data name
// service-data arg should be 'service-data'
if (args[8] !== 'service-data') {
  shell.echo('Command syntaxe error (service-data)');
  // eslint-disable-next-line max-len
  shell.echo('example (get) : npm run connect-page-to-redux-service feature users page UserListPage service UserList service-data users query-type get');
  // eslint-disable-next-line max-len
  shell.echo('example (post) : npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user');
  shell.exit(1);
}

if (args.length < 10) {
  // eslint-disable-next-line max-len
  shell.echo('(Service data name is mandatory example (get) : npm run connect-page-to-redux-service feature users page UserListPage service UserList service-data users query-type get');
  // eslint-disable-next-line max-len
  shell.echo('Service data name is mandatory example (post) : npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user');
  shell.exit(1);
}

// find query type
// query type arg should be 'query-type'
if (args[10] !== 'query-type') {
  shell.echo('Command syntaxe error (query-type)');
  // eslint-disable-next-line max-len
  shell.echo('example (get) : npm run connect-page-to-redux-service feature users page UserListPage service UserList service-data users query-type get');
  // eslint-disable-next-line max-len
  shell.echo('example (post) : npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user');
  shell.exit(1);
}

if (args.length < 12) {
  // eslint-disable-next-line max-len
  shell.echo('(Query type is mandatory example (get) : npm run connect-page-to-redux-service feature users page UserListPage service UserList service-data users query-type get');
  // eslint-disable-next-line max-len
  shell.echo('Query type is mandatory example (post) : npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user');
  shell.exit(1);
}

const featureName = args[3];
const pageName = args[5];
const serviceName = args[7];
const serviceData = args[9];
const queryType = args[11];
if (queryType === 'post') {
  // find query params
  // query params arg should be 'query-params'
  if (args[12] !== 'query-params') {
    shell.echo('Command syntaxe error (query-params)');
    // eslint-disable-next-line max-len
    shell.echo('example (post) : npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user');
    shell.exit(1);
  }

  if (args.length < 13) {
    // eslint-disable-next-line max-len
    shell.echo('Query params is mandatory example (post) : npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user');
    shell.exit(1);
  }

  // call sh script with post
  const queryParams = args[13];
  console.log('queryParams : ', queryParams);
  shell.exec(`./scripts/connect-page-to-redux-service.sh -feature ${featureName} -page ${pageName} -service ${serviceName} -service-data ${serviceData} -query-type post -query-params ${queryParams}`);
} else if (queryType === 'get') {
  // call sh script with get
  shell.exec(`./scripts/connect-page-to-redux-service.sh -feature ${featureName} -page ${pageName} -service ${serviceName} -service-data ${serviceData} -query-type get`);
} else {
  // wrong query type
  shell.echo('Command syntaxe error (query-type) must be get or post');
  // eslint-disable-next-line max-len
  shell.echo('example (get) : npm run connect-page-to-redux-service feature users page UserListPage service UserList service-data users query-type get');
  // eslint-disable-next-line max-len
  shell.echo('example (post) : npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user');
  shell.exit(1);
}
