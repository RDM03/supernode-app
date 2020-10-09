const dotenv = require('dotenv');

dotenv.config();
exports.config = {
  user: process.env.BROWSERSTACK_USERNAME,
  key: process.env.BROWSERSTACK_ACCESS_KEY,

  updateJob: false,
  specs: [
    './specs/test.js'
  ],
  exclude: [],

  capabilities: [{
    project: "supernode-app",
        build: 'Supernode Android',
        name: 'supernode_tests',
        device: 'Google Pixel 3',
        os_version: "9.0",
        app: process.env.BROWSERSTACK_APP_ID || 'bs://edc707fd884af301bf3d0903aee62bdff33fa202',
        'browserstack.debug': true
  }],

  logLevel: 'info',
  coloredLogs: true,
  screenshotPath: './errorShots/',
  baseUrl: '',
  waitforTimeout: 10000,
  connectionRetryTimeout: 90000,
  connectionRetryCount: 3,

  framework: 'mocha',
  mochaOpts: {
    ui: 'bdd',
    timeout: 20000
  }
};
