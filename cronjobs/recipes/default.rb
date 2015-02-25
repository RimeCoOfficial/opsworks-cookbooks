# 
# Author:: Juan Manuel Torres <kinojman@gmail.com>
# Cookbook Name:: cronjobs
# Recipe:: default
#
# Create custom cron jobs using configuration values in the Custom JSON
#

# http://docs.aws.amazon.com/opsworks/latest/userguide/workingcookbook-extend-cron.html

# https://docs.chef.io/chef/resources.html#cron
#   command   The command to be run or the path to a file that contains the command to be run.
#   day       The day of month at which the cron entry should run (1 - 31). Default value: *.
#   home      Use to set the HOME environment variable.
#   hour      The hour at which the cron entry should run (0 - 23). Default value: *.
#   mailto    Use to set the MAILTO environment variable.
#   minute    The minute at which the cron entry should run (0 - 59). Default value: *.
#   month     The month in the year on which a cron entry should run (1 - 12). Default value: *.
#   path      Use to set the PATH environment variable.
#   provider  Optional. Use to explicitly specify a provider. (See “Providers” section below for more information.)
#   shell     Use to set the SHELL environment variable.
#   user      The name of the user that runs the command. If the user attribute is changed, the original user for the crontab program will continue to run until that crontab program is deleted. Default value: root.
#   weekday   The day of the week on this entry should run (0 - 6), where Sunday = 0. Default value: *. May be entered as a symbol, e.g. :monday or :friday.

node[:custom_env][:cron_jobs].each do |cron_values|
  cron "#{cron_values[:name]}" do
    minute  "#{cron_values[:minute]}"
    hour    "#{cron_values[:hour]}"
    day     "#{cron_values[:day]}"
    month   "#{cron_values[:month]}"
    weekday "#{cron_values[:weekday]}"
    command "#{cron_values[:command]}"
  end
end