// npm run add-page page-name
// npm run add-page feature feature-name page page-name components component1 component2
import shell from 'shelljs';

const args = process.argv;

// find feature name
// feature arg should be 'feature'
if (args[2] !== 'feature') {
  shell.echo('Command syntaxe error');
  shell.echo('(example : npm run add-page feature feature-name page page-name components component1 component2)');
  shell.exit(1);
}
if (args.length < 4) {
  shell.echo('Feature name is mandatory (example : npm run add-page feature feature-name page page-name)');
  shell.exit(1);
}

// find page name
// page arg should be 'page'
if (args[4] !== 'page') {
  shell.echo('Command syntaxe error');
  shell.echo('(example : npm run add-page feature feature-name page page-name components component1 component2)');
  shell.exit(1);
}

if (args.length < 6) {
  shell.echo('Page name is mandatory (example : npm run add-page feature feature-name page page-name)');
  shell.exit(1);
}

// if components is mentionned then
// we should have at least one components
let components = [];
if (args.length > 6) {
  // if we have components arg then
  // we should have at least one components
  if (args.length === 7) {
    shell.echo('Command syntaxe error');
    shell.echo('(example : npm run add-page feature feature-name page page-name components component1 component2)');
    shell.exit(1);
  }

  // components args name should be components
  if (args[6] !== 'components') {
    shell.echo('Command syntaxe error');
    shell.echo('(example : npm run add-page feature feature-name page page-name components component1 component2)');
    shell.exit(1);
  }

  // components name list
  components = args.slice(7, args.length);
}

// create feature if not exist
const featureName = args[3];
const pageName = args[5];

// eslint-disable-next-line max-len
if (components
  && components.length) {
  shell.exec(`create-page.sh -feature ${featureName} -page ${pageName} -components ${components.join(' ')}`);
} else {
  shell.exec(`create-page.sh -feature ${featureName} -page ${pageName}`);
}
