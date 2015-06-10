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

##phpenv
This cookbook contains utility recipes to help setup applications.

###phpenv::memoryswap
AWS micro instances have little memory (615 MB), and can often times run out of memory. 
I have run into memory issues when doing composer installs or updates. 

Use recipe on **Setup** ONLY.

See these references for more info:
- [AWS Micro Instances](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts_micro_instances.html)
- [Using composer in AWS + Micro Instance](http://onema.io/blog/aws-micro-instance-and-composer/)
- [Adding Swap to any EC2 Instance](http://www.the-tech-tutorial.com/?p=1408)
- [Symfony2, Composer, Capifony and an EC2 Micro instance](http://jonathaningram.com.au/category/composerphp/)
- [ErrorException: proc_open(): fork failed - Cannot allocate memory in phar](https://github.com/composer/composer/issues/945)

###phpenv::php_mcrypt_enable
This recipe should only be used with the OpsWorks OS Package php5-mcrypt in Ubuntu 14.04. This package is not enable by default and the purpose of this recipe is to run `php5enmod mcrypt` if the file `mcrypt.ini` exisists with in `/etc/php5/mods-available/`.

Use recipe on **Setup** ONLY.

###phpenv::php_mongodb
This recipe installs the mongodb php module using PECL (Requires the **php-pear** OS package). 

Use recipe on **Setup** ONLY.

###phpenv::php_redis
This recipe installs the redis php module using PECL (Requires the **php-pear** OS package). 

Use recipe on **Setup** ONLY.

###phpenv::htaccess_env_vars
This recipe creates a custom .htaccess in the directory of your choice and sets
environment variables using the apache setEnv directive. A default .htaccess file is
provided with this recipe, but a custom .htaccess file can be used. 
The recipe can create a unique .htaccess file for each application in the stack. 
Two configuration values are required to make this recipe work: ```htaccess_template``` for example htaccess.rb, 
and ```path_to_vars``` This is the path where the htaccess file will be created. 
The evironment variables can be set in the custom Chef JSON like this:

```
{
    "custom_env": {
        "staging_site": {
            "environment": "staging",
            "htaccess_template": "htaccess.rb",
            "path_to_vars": "web",
            "env_vars" : [ 
                "CACHE_TIME 3600", 
                "SOME_API_KEY BlahBlah", 
                "ANOTHER_API_KEY helloWorld!" 
            ] 
        },
        "production_site": {
            "environment": "production",
            "htaccess_template": "advanced_htaccess.rb",
            "path_to_vars": "public",
            "env_vars" : [ 
                "CACHE_TIME 1234", 
                "SOME_API_KEY nahnah", 
                "ANOTHER_API_KEY hello-monkey!" 
            ] 
        }
    }
}
```

The name custom_env is required. The values staging_site and production_site are the applications created in this stack and
must match the application name.

The array of values ```"env_vars"``` will have any environment variable needed to run the application. The format is

"KEY value" (KEY space VALUE)

in the example above the production site $_SERVER array would look like this:

```php
Array
(
//... 
    [ANOTHER_API_KEY] => hello-monkey!
    [GA_API_CACHE_TIME] => 1234
    [SOME_API_KEY] => nahnah
//... 
)
```

**NOTE: THE RECIPE WILL NOT WORK IF YOUR APPLICATION NAME HAS SPACES OR DASHES "-" BETWEEN WORDS. Use underscores "_" to separate words to avoid problems**
**NOTE2: THESE ENVIRONMENT VALUES WILL NOT BE AVAILABLE IN THE TERMINAL. ANY TASKS YOU RUN FROM THE TERMINAL MUST SET THE EVIRONMENT NAME**
The .htaccess generated by this recipe will look like this:

```
<IfModule mod_rewrite.c>
  RewriteEngine on 
  RewriteCond %{REQUEST_FILENAME} !-f 
  RewriteCond %{REQUEST_FILENAME} !-d 
  RewriteRule ^(.*)$ index.php/$1 [L] 
  
  <IfModule mod_env.c> 
    # Environment Variables for application production_site 
    SetEnv ANOTHER_API_KEY hello-monkey! 
    SetEnv GA_API_CACHE_TIME 1234 
    SetEnv SOME_API_KEY nahnah 
  </IfModule> 
</IfModule>
```

###phpenv::php_env_vars
This recipe creates a custom ```environment_variables.php``` in the directory of your choice and sets
environment variables using the [putenv](http://php.net/manual/en/function.putenv.php) function. 
In order to use this file and have the env vars available on every request, the file must be 
included each time. The recipe can create a unique file for each application in the stack. 
One configuration values is required to make this recipe work: ```path_to_vars```. 
This is the path where the ```environment_variales.php``` file will be created. 

The evironment variables can be set in the custom Chef JSON like this:

```
{
    "custom_env": {
        "staging_site": {
            "environment": "staging",
            "path_to_vars": "src/acme/application/config/staging",
            "env_vars" : [ 
                "CACHE_TIME=3600", 
                "SOME_API_KEY=BlahBlah", 
                "ANOTHER_API_KEY=helloWorld!" 
            ] 
        },
        "production_site": {
            "htaccess_template": "advanced_htaccess.rb",
            "path_to_vars": "src/acme/application/config/production",
            "env_vars" : [ 
                "CACHE_TIME=1234", 
                "SOME_API_KEY=nahnah", 
                "ANOTHER_API_KEY=hello-monkey!" 
            ] 
        }
    }
}
```

The name custom_env is required. The values staging_site and production_site are the applications created in this stack and
must match the application name.

The array of values ```"env_vars"``` will have any environment variable needed to run the application. The format is

"KEY=value" 


Note that in this case we do not add an environment value for FUEL_ENV, this is 
because the recipe will use the application value ```environment``` to set it. 

**NOTE: THE RECIPE WILL NOT WORK IF YOUR APPLICATION NAME HAS SPACES OR DASHES "-" BETWEEN WORDS. Use underscores "_" to separate words to avoid problems**
**NOTE2: THESE ENVIRONMENT VALUES WILL NOT BE AVAILABLE IN THE TERMINAL. ANY TASKS YOU RUN FROM THE TERMINAL MUST SET THE EVIRONMENT NAME**
The ```environment_variables.php``` generated by this recipe will look like this:

```
    // Environment Variables for application production_site 
    putenv("ANOTHER_API_KEY hello-monkey!");
    putenv("FUEL_ENV production");
    putenv("GA_API_CACHE_TIME 1234");
    putenv("SOME_API_KEY nahnah");
```

##composer
This coockbook contains recipes to run the install and update commands. 

###composer::install
This will download the latest version of composer from [https://getcomposer.org/installer](https://getcomposer.org/installer) 
to the current deployment directory and will run ```$ php composer.phar install --optimize-autoloader```.

###composer::update
Similar to install this recipe will download the latest version of composer from [https://getcomposer.org/installer](https://getcomposer.org/installer) 
to the current deployment directory and will run ```$ php composer.phar update```.
