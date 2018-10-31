1. Ensure you have bundler installed
1. `bundle install`
1. set up ENV file (we'll call it `my.env`). Required values:
    * `ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxx`
    * `AUTH_TOKEN=xxxxxxxx`
    * `FROM_NUMBERS=1234567890,2345678901`
1. `source my.env && bundle exec sms.rb`