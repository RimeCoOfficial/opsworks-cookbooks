# cronjobs

###### Forked from: https://github.com/onema/opsworks-chef-cookbooks/

This cookbook creates cronjobs based on configuration values.

Use on **deploy** life cycle.

For more information see the AWS OpsWorks documentation.

All parameters are required.

### Examples `cronjobs::default`

Default will create multiple cronjobs based on the following configuration values:

``` json
{
  "custom_env": {
    "cron_jobs": [  
      {
        "name"    : "echo hi",
        "minute"  : "*/1",
        "hour"    : "*",
        "day"     : "*",
        "month"   : "*",
        "weekday" : "*",
        "command" : "%Q{ echo 'hi' >> /home/ubuntu/test.txt }"
      }
    ]
  }
}
```

``` json
{
  "custom_env": {
    "cron_jobs": [  
      {
        "name"    : "Send an email every sunday at 8:10",
        "minute"  : "10", 
        "hour"    : "8", 
        "day"     : "*",
        "month"   : "*",
        "weekday" : "6",
        "command" : "cd /srv/www/staging_site/current && php .lib/mailing.php" 
      },
      {
        "name"    : "Run at 8:00 PM every weekday Monday through Friday ONLY in November.", 
        "minute"  : "0", 
        "hour"    : "20",
        "day"     : "*",
        "month"   : "10", 
        "weekday" : "1-5",
        "command" : "cd /srv/www/staging_site/current && php app/console command:start:jobs" 
      },
      {
        "name"    : "Run Every 12 Hours - 1AM and 1PM",
        "minute"  : "*",
        "hour"    : "1-13",
        "day"     : "*",
        "month"   : "*",
        "weekday" : "*",
        "command" : "cd /srv/www/production_site/current && php app/console hello:world" 
      },
      {
        "name"    : "Run every 15 minutes",
        "minute"  : "*/15", 
        "hour"    : "*",
        "day"     : "*",
        "month"   : "*",
        "weekday" : "*",
        "command" : "cd /srv/www/production_site/current && php app/console memory:leak" 
      },
    ]
  }
}
```