var assert = require('assert');
const find = require('appium-flutter-finder');
const dotenv = require('dotenv');
const wdio = require('webdriverio');
dotenv.config();


const opts = {
  capabilities: {
    platformName: 'Android',
    deviceName: 'Google Pixel 3',
    app: process.env.BROWSERSTACK_APP_ID,
    automationName: 'supernode_tests'
  }
};

describe('tests', () => {
    it('can login', async () => {
        const driver = await wdio.remote(opts);
        var home_logo = find.byValueKey('home_logo');
        var home_login = find.byValueKey('home_login');
        var supernode_menu = find.byValueKey('home_supernode_menu');
        var server_select = find.byValueKey('MXCtest');
        var email_field = find.byValueKey('home_email');
        var password_field = find.byValueKey('home_pass');

        home_login.waitForDisplayed({timeout: 10000})

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

    });
    it('can flex stake', async () => {
        var stake_button = find.byValueKey('home_stake');
        var stake_length = find.byValueKey('stakeFlex');
        var stake_amount = find.byValueKey('stakeAmount');
        var stake_proceed = find.byValueKey('submitButton');
        var stake_status = find.byValueKey('stake_status');
        var done = find.byValueKey('stake_done');
        var close = find.byValueKey('stake_close');

        await driver.elementClick(stake_button);
        await driver.elementClick(stake_length);
        await driver.elementSendKeys(stake_amount, '20');
        await driver.elementClick(stake_proceed);
        stake_proceed.waitForClickable({ timeout: 40000 })
        await driver.elementClick(stake_proceed);
        assert.strictEqual(await driver.getElementText(stake_status), 'Stake successful.')
        await driver.elementClick(done);
        await driver.elementClick(close);
    });
    it('can find stake in wallet', async () => {
        var nav_wallet = find.byValueKey('bottomNavBar_wallet');
        var wallet_nav_stake = find.byValueKey('tabBar_stake');

        var stake_close = find.byValueKey('stake_close');

        await driver.elementClick(nav_wallet);
        assert.strictEqual(await driver.getElementText('current_balance_label'), 'Current Balance');
        await driver.elementClick(wallet_nav_stake);

        //TODO find a way to save the stake id while setting it and use stakeItem_${stakeId} as an identifier

    });
    // TODO work out interaction with GAuth to unstake
    // perhaps you can mock a success from the api??

    it('can navigate gateway menu and add gateway', async () => {
            //gateway menu navigation and interaction
            var nav_gateway = find.byValueKey('bottomNavBar_gateway');
            var add_gateway = find.byValueKey('gateway_add');
            var serial_textbox = find.byValueKey('gateway_serial_key');
            var gateway_add_confirm = find.byValueKey('gateway_add_confirm');
            var
            var gateway_update = find.byValueKey('gateway_update');
            var gateway_close = find.byValueKey('gateway_close');

            await driver.elementClick(nav_gateway);
            await driver.elementClick(gateway_add);
            // may need a new serial for testing
            // investigate qr scan testing??
            await driver.elementSendKeys(serial_textbox, 'M2XSTEFANOO');
            await driver.elementClick(gateway_add_confirm);
            await driver.execute('flutter:scrollIntoView', gateway_update, {alignment: 0.1});
            await driver.elementClick(gateway_update);
            await driver.elementClick(gateway_close);


        /* add valuekeys for add_gateway, gateway_update, gateway_close */

    });
});

