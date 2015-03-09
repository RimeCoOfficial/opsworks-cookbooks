AWS OpsWorks Cookbooks.
=======================

# Cookbooks

## cronjobs
This cookbook creates cronjobs based on configuration values.
Use on *setup* and *deploy* life cycles.

For more information see the AWS OpsWorks documentation.

All parameters are required.

### Examples `cronjobs::default`

Default will create multiple cronjobs based on the following configuration values:

```json
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
```json
{
  "custom_env": {
    "cron_jobs": [  
      {
        // Send an email every sunday at 8:10
        "name"    : "send_email_sunday_8",
        "minute"  : "10", 
        "hour"    : "8", 
        "day"     : "*",
        "month"   : "*",
        "weekday" : "6",
        "command" : "cd /srv/www/staging_site/current && php .lib/mailing.php" 
      },
      {
        // Run at 8:00 PM every weekday Monday through Friday ONLY in November. 
        Notice there is no day
        "name"    : "run_at_20h_nov", 
        "minute"  : "0", 
        "hour"    : "20",
        "day"     : "*",
        "month"   : "10", 
        "weekday" : "1-5",
        "command" : "cd /srv/www/staging_site/current && php app/console command:start:jobs" 
      },
      {
        // Run Every 12 Hours - 1AM and 1PM
        "name"    : "run_every_12h",
        "minute"  : "*",
        "hour"    : "1-13",
        "day"     : "*",
        "month"   : "*",
        "weekday" : "*",
        "command" : "cd /srv/www/production_site/current && php app/console hello:world" 
      },
      {
        // Run every 15 minutes
        "name"    : "do_something_stupid_every_15m",
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

### Examples `cronjob2::default` .rb
Run every 1 minutes
```ruby
cron "echo hi" do
  minute "*/1"
  command "%Q{ echo 'hi' >> /home/ubuntu/test.txt }"
```

```ruby
cron "do_something_stupid_every_15m" do
  minute "*/1"
  command "cd /srv/www/production_site/current && php app/console memory:leak"
end
```
