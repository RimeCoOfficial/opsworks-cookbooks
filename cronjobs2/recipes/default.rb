# 
# Author:: Juan Manuel Torres <kinojman@gmail.com>
# Cookbook Name:: cronjobs
# Recipe:: default
#
# Create custom cron jobs using configuration values in the Custom JSON
#

cron "sync_service oauth task" do
  minute "*/1"
  command "%Q{ echo 'hi' >> /home/ubuntu/test.txt }"
end