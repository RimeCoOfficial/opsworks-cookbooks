# To install latest nginx
template "nginx.repo" do
  path "/etc/yum.repos.d/nginx.repo"
  source "nginx.repo.erb"
  mode 0644
  user "root"
  group "root"
end

# chkconfig --list (default)
# nginx 0:off 1:off 2:on  3:on  4:on  5:on  6:off
package "nginx" do
  action :install
  options "--disablerepo=* --enablerepo=nginx"
end

# Disable port 80 server
file "/etc/nginx/conf.d/default.conf" do
  action :delete
end

template "nginx.conf" do
  path "/etc/nginx/nginx.conf"
  source "nginx.conf.erb"
  action :create
  owner "root"
  group "root"
  mode 0644
  notifies :reload, "service[nginx]"
end

bash "prepare ssl" do
  code <<-EOC
mkdir -p /etc/nginx/ssl
echo #{node["nginx"]["economy_node_proxy"]["crt"]} > /etc/nginx/ssl/cert.crt
echo #{node["nginx"]["economy_node_proxy"]["key"]} > /etc/nginx/ssl/cert.key
  EOC
end

template "economy_node_proxy.conf" do
  path "/etc/nginx/conf.d/economy_node_proxy.conf"
  source "economy_node_proxy.conf.erb"
  action :create
  owner "root"
  group "root"
  mode 0644
  notifies :reload, "service[nginx]"
end

phpmyadmin_name_is_specified = node["nginx"]["economy_node_proxy"]["phpmyadmin_name"] != ""
include_recipe "phpmyadmin::nginx" if phpmyadmin_name_is_specified

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start]
end

