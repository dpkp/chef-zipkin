directory node[:zipkin][:install_path] do
  action :create
end

package 'unzip' do
  action :install
end

github_asset 'zipkin-query-service' do
  name 'zipkin-query-service.zip'
  repo 'twitter/zipkin'
  release node[:zipkin][:version]
end

execute 'unzip zipkin-query-service' do
  command "unzip #{Chef::Config[:file_cache_path]}/github_assets/twitter/zipkin/#{node[:zipkin][:version]}/zipkin-query-service.zip -d #{node[:zipkin][:install_path]}"
  not_if { File.exist?("/opt/zipkin/zipkin-query-service-#{node[:zipkin][:version]}") }
end

template "query-dev.scala" do
  path "#{node[:zipkin][:install_path]}/zipkin-query-service-#{node[:zipkin][:version]}/config/query-dev.scala"
  source 'query_config.erb'
  notifies :restart, 'service[zipkin-query-service]', :delayed
  mode '0644'
  action :create
end


template '/etc/init/zipkin-query-service.conf' do
  source 'query-upstart.erb'
  notifies :restart, 'service[zipkin-query-service]', :delayed
  mode '0644'
  action :create
end

service 'zipkin-query-service' do
  provider Chef::Provider::Service::Upstart
  supports :start => true, :stop => true, :restart => true, :status => true
  action [ :enable, :start ]
end
