var assert = require('assert');
const find = require('appium-flutter-finder');
const dotenv = require('dotenv');
const wdio = require('webdriverio');
dotenv.config();



const osSpecificOps = {
  //process.env.APPIUM_OS === 'android'
  //  ? {
        platformName: 'Android',
        deviceName: 'Google Pixel 3',
        os_version: '9.0',
        app: process.env.BROWSERSTACK_APP_ID,
        'browserstack.debug': true
     }
//    : process.env.APPIUM_OS === 'ios'
//    ? {
//        platformName: 'iOS',
//        platformVersion: '12.2',
//        deviceName: 'iPhone X',
//        noReset: true
//      }
//    : {};

const opts = {
  //port: 4723,
  capabilities: {
    ...osSpecificOps,
    automationName: 'Flutter'
  }
};



(async () => {
    const driver = await wdio.remote(opts);
    var home_logo = find.byValueKey('home_logo');
    var home_login = find.byValueKey('home_login');
    var supernode_menu = find.byValueKey('home_supernode_menu');
    var server_select = find.byValueKey('MXCtest');
    var email_field = find.byValueKey('home_email');
    var password_field = find.byValueKey('home_pass');
    //await home_logo.waitForDisplayed({ timeout: 30000 });
    //await browser.pause(5000);
    for(var i; i < 7; i++){
        await driver.elementClick(home_logo);
     }

//    browser
//        //.waitForVisible(supernode_menu, 30000)
//        .element(supernode_menu).click()
//        //.waitForVisible(server_select, 30000)
//        .element(server_select).click()
//        .element(email_field).keys(process.env.TESTSERVER_EMAIL)
//        .element(password_field).keys(process.env.TESTSERVER_PASS);
    await driver.elementClick(supernode_menu);
    await driver.elementClick(server_select);
    await driver.elementSendKeys(email_field, process.env.TESTSERVER_EMAIL);
    await driver.elementSendKeys(password_field, process.env.TESTSERVER_PASS);

    assert.strictEqual(await driver.getElementText(email_field), process.env.TESTSERVER_EMAIL);
    assert.strictEqual(await driver.getElementText(password_field_field), process.env.TESTSERVER_PASS);
    await driver.elementClick(home_login);
  });

