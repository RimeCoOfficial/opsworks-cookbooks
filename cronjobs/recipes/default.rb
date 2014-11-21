# cron "sync_service oauth task" do
#   minute "*/2"
#   command "cd /srv/www/log_pixel/current && php index.php task sync_service oauth"
# end

# 
# Author:: Juan Manuel Torres <kinojman@gmail.com>
# Cookbook Name:: cronjobs
# Recipe:: default
#
# Create custom cron jobs using configuration values in the Custom JSON
#

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