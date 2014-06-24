directory node[:zipkin][:install_path] do
  action :create
end

package 'unzip' do
  action :install
end

github_asset 'zipkin-web' do
  name 'zipkin-web.zip'
  repo 'twitter/zipkin'
  release node[:zipkin][:version]
end

execute 'unzip zipkin-web' do
  command "unzip #{Chef::Config[:file_cache_path]}/github_assets/twitter/zipkin/#{node[:zipkin][:version]}/zipkin-web.zip -d #{node[:zipkin][:install_path]}"
  not_if { File.exist?("/opt/zipkin/zipkin-web-#{node[:zipkin][:version]}") }
end

template "web-dev.scala" do
  path "#{node[:zipkin][:install_path]}/zipkin-web-#{node[:zipkin][:version]}/config/web-dev.scala"
  source 'web_config.erb'
  notifies :restart, 'service[zipkin-web]', :delayed
  mode '0644'
  action :create
end

template '/etc/init/zipkin-web.conf' do
  source 'web-upstart.erb'
  notifies :restart, 'service[zipkin-web]', :delayed
  mode '0644'
  action :create
end

service 'zipkin-web' do
  provider Chef::Provider::Service::Upstart
  supports :start => true, :stop => true, :restart => true, :status => true
  action [ :enable, :start ]
end
