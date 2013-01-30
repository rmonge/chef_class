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

cookbook_file "/opt/splunk/etc/system/splunk_cde.tgz" do
  source "splunk_cde.tgz"
  mode 0755
  owner "root"
  group "root"
end

bash "install_splunk_cde" do
  cwd "/opt/splunk/etc/system/"
    code <<-EOH
     tar -zxvf splunk_cde.tgz
     chown -R splunk local
     EOH
end

package "tree"

