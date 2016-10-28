**README**

My personal website. While you are free to replicate this please make sure you personalize it to you and properly source where you found this. :)

Dependent Services:
- SendGrid (sendgrid.com)
- Travis CI (You will need to swap out or remove the Slack integration)

To use this you must have Docker installed:
./build.sh secret_key sql_pass sendgrid_api_key

 Alternatively you can use a service like Heroku and just plug in the env values.
