#
# Cookbook Name:: splunk
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
# Cookbook Name:: splunk
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

log "Installing Splunk version 4"

user "splunk" do
 action :create
 shell "/bin/bash"
end 


directory "/opt/splunk" do   
  owner "splunk"
  mode "0755"   
  action :create 
end 

remote_file "/opt/splunk.tar" do   
  source "https://rs-training-assets.s3.amazonaws.com/splunk-4.3.4-136012-Linux-x86_64.tar"
  action :create_if_missing 
end 

bash "install_splunk" do
  cwd "/opt"
  code <<-EOH
    tar -xvf splunk.tar
    chown -R splunk /opt/splunk
    EOH
end 

templates "/opt/splunk/etc/system/local/inputs.conf" do
  source "inputs.conf.erb"
  mode 0755
  owner "splunk"
  group "root"
  action :create
end

templates "/opt/splunk/etc/system/local/web.conf" do
  source "web.conf.erb"
  mode 0755
  owner "splunk"
  group "root"
  action :create
end


package "tree"

