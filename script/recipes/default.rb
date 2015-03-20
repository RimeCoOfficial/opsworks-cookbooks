# Execute depending upon server
# export CI_ENV="production" or
# setenv CI_ENV="production"

bash "set CI_ENV" do
  code <<-EOH
    export CI_ENV="production"
  EOH
end