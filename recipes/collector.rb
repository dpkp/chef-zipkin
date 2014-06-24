directory node[:zipkin][:install_path] do
  action :create
end

package 'unzip' do
  action :install
end

github_asset 'zipkin-collector-service' do
  name 'zipkin-collector-service.zip'
  repo 'twitter/zipkin'
  release node[:zipkin][:version]
end

execute 'unzip zipkin-collector-service' do
  command "unzip #{Chef::Config[:file_cache_path]}/github_assets/twitter/zipkin/#{node[:zipkin][:version]}/zipkin-collector-service.zip -d #{node[:zipkin][:install_path]}"
  not_if { File.exist?("/opt/zipkin/zipkin-collector-service-#{node[:zipkin][:version]}") }
end

template "collector-dev.scala" do
  path "#{node[:zipkin][:install_path]}/zipkin-collector-service-#{node[:zipkin][:version]}/config/collector-dev.scala"
  source 'collector_config.erb'
  notifies :restart, 'service[zipkin-collector-service]', :delayed
  mode '0644'
  action :create
end

template '/etc/init/zipkin-collector-service.conf' do
  source 'collector-upstart.erb'
  notifies :restart, 'service[zipkin-collector-service]', :delayed
  mode '0644'
  action :create
end

service 'zipkin-collector-service' do
  provider Chef::Provider::Service::Upstart
  supports :start => true, :stop => true, :restart => true, :status => true
  action [ :enable, :start ]
end
