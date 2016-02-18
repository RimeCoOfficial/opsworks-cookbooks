directory "/tmp/aws-cache" do
  mode 0777
  owner 'root'
  group 'root'
  action :create
end

directory "/tmp/ci" do
  mode 0777
  owner 'root'
  group 'root'
  action :create
end

directory "/tmp/ci/upload" do
  mode 0777
  owner 'root'
  group 'root'
  action :create
end