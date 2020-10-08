run (user and pass available on browserstack)

```
npm i

curl -u "user:pass" \
   -X POST "https://api-cloud.browserstack.com/app-automate/upload" \
   -F "file=@/build/app/outputs/flutter-apk/app-prod-release.apk"
```
Add output of curl to .env as BROWSERSTACK_APP_ID as well as the BROWSERSTACK_USERNAME, BROWSERSTACK_ACCESS_KEY, TESTSERVER_EMAIL, and TESTSERVER_PASS (available on lastpass or from Stefan)

```npm run login```