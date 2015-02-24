# 
# Author:: Juan Manuel Torres <kinojman@gmail.com>
# Cookbook Name:: cronjobs
# Recipe:: default
#
# Create custom cron jobs using configuration values in the Custom JSON
#

cron "echo hi" do
  minute "*/1"
  command "%Q{ echo 'hi' >> /home/ubuntu/test.txt }"
end

cron "echo hi" do
  minute "*/1"
  command "cd /srv/www/log_pixel/current && php index.php task sync_url extract   60"
end