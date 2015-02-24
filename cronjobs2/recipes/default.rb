cron "sync_url extract" do
  minute "*/1"
  command "cd /srv/www/log_pixel/current && php index.php task sync_url extract   60"
end