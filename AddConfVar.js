// npm run add-feature feature-name
import shell from 'shelljs';

const args = process.argv;
console.log('args : ', args);
if (args.length < 6) {
  shell.echo('Variable name and value are mandatory (example : npm run add-conf-var name var-name value var-value)');
  shell.exit(1);
}

if (args[2] !== 'name') {
  shell.echo('Command syntaxe error (name)');
  shell.echo('(example : npm run add-conf-var name var-name value var-value)');
  shell.exit(1);
}

if (args[4] !== 'value') {
  shell.echo('Command syntaxe error (value)');
  shell.echo('(example : npm run add-conf-var name var-name value var-value)');
  shell.exit(1);
}

// var name
const varName = args[3];

//var value
const varValue = args[5];

// execute script
shell.exec(`./scripts/add-conf-var.sh -name ${varName} -value ${varValue}`);
