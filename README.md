# react-cmd-cli

# Add new feature :

```javascript
npm run add-feature your-feature-name
```

This command will create a folder named : **feature-name**
The folder structure will be :
- pages
- components
- services
- commons

# Add new page (without components):

```javascript
npm run add-page feature feature-name page page-name
```

- Create page **page-name** under feature **feature-name**.
- Add page to Routes.jsx.

# Add new page (with components):

```javascript
npm run add-page feature feature-name page page-name components component1 component2
```

- Create page **page-name** under feature **feature-name**.
- Add page to Routes.jsx.
- Create components and components tests files.
- Call components inside the page.


# Init project with redux & saga :

```javascript
npm run init-redux-saga
```

This script will install redux and saga dependencies and needed HOCs.
It will also modify Routes.jsx export to :

```javascript
import withReduxBoot from './core/redux/withReduxBoot;
export default withReduxBoot(Routes);
```

# Connect page to redux & saga service :

```javascript
npm run connect-page-to-redux-service feature feature-name page page-name service service-name service-data service-data-name query-type post/get query-params object-name
```

## Get :
```javascript
npm run connect-page-to-redux-service feature users page UserListPage service UserList service-data users query-type get
```

## Post :
```javascript
npm run connect-page-to-redux-service feature users page UserAddPage service UserAdd service-data user query-type post query-params user
```

**This script will automatically create :**

- redux actions 
- redux reducer
- saga service & link reducer with yield and actionType
- add service to saga root
- mapStateToProps & mapDispatchToProps in the page
- export page 

# Note
Each service has its own : reducer, action, service file.
