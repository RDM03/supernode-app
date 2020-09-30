run 

```
npm i

curl -u "xinhu4:c9WwDhpXYtysU1y3yd7d" \
   -X POST "https://api-cloud.browserstack.com/app-automate/upload" \
   -F "file=@/path/to/apk/file"
```
Add output of curl to .env as BROWSERSTACK_APP_ID as well as the BROWSERSTACK_USERNAME, BROWSERSTACK_ACCESS_KEY, TESTSERVER_EMAIL, and TESTSERVER_PASS (available on lastpass or from Stefan)

```npm run login```