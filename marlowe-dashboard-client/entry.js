/*eslint-env node*/
import './static/css/main.css';

require('./src/Main.purs').main();

if (module.hot) {
  module.hot.accept();
}
