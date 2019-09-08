// npm run add-feature feature-name
import shell from 'shelljs';

const args = process.argv;
if (args.length < 3) {
  shell.echo('Feature name is mandatory (example : npm run add-feature your-feature-name)');
  shell.exit(1);
}

// create feature directory
const featureName = args[2];
shell.exec(`./react-cli/scripts/create-feature.sh ${featureName}`);
