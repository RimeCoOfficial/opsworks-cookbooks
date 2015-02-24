# cron "do_something_stupid_every_15m" do
#   minute "*/1"
#   command "cd /srv/www/production_site/current && php app/console memory:leak"
# end