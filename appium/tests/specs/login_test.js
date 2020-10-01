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
  capabilities: {
    ...osSpecificOps,
    automationName: 'Flutter'
  }
};



(async () => {

    //login
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
        console.log('logo click '+ i)
     }
    await driver.elementClick(supernode_menu);
    await driver.elementClick(server_select);
    await driver.elementSendKeys(email_field, process.env.TESTSERVER_EMAIL);
    await driver.elementSendKeys(password_field, process.env.TESTSERVER_PASS);

    assert.strictEqual(await driver.getElementText(email_field), process.env.TESTSERVER_EMAIL);
    assert.strictEqual(await driver.getElementText(password_field_field), process.env.TESTSERVER_PASS);
    await driver.elementClick(home_login);

    //staking

    //flex stake
    var stake_button = find.byValueKey('home_stake');
    var stake_length = find.byValueKey('stake_length_flex');
    var stake_textbox = find.byValueKey('stake_amount');
    var stake_confirm = find.byValueKey('stake_confirm');
    var stake_proceed = find.byValueKey('submitButton');
    var stake_success = find.byValueKey('stake_status');
    var done = find.byValueKey('stake_done');

    await driver.elementClick(stake_button);
    await driver.elementClick(stake_length);
    await driver.elementSendKeys(stake_amount, '20');
    await driver.elementClick(stake_confirm);
    await driver.getElementText(find.byText('Proceed Anyway'));
    await driver.elementClick(stake_proceed);
    assert.strictEqual(await driver.getElementText(stake_success), 'Stake successful.')
    await driver.elementClick(done);



  });