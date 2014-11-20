cron "sync_service oauth task" do
  minute "*/2"
  command "cd /srv/www/log_pixel/current && php index.php task sync_service oauth"
end
