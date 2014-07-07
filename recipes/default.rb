package "apt"
#
apt_repository "rrepository" do
  uri "#{node['r31bioc214']['Rapturl']}"
  distribution "precise/"
  keyserver "keyserver.ubuntu.com"
  key "E084DAB9"
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end
package "r-base"

# home directory
home = "/home/"+node[:current_user]

# R version check script
cookbook_file '/home/vagrant/showversion.R' do
  source "showversion.R"
  owner "vagrant"
  group "vagrant"
  mode "0755"
end
# Bioconductor version check script
cookbook_file "#{home}/showBioconductorVersion.R" do
  source "showBioconductorVersion.R"
  owner "vagrant"
  group "vagrant"
  mode "0755"
end

# .Renviron
cookbook_file "#{home}/.Renviron" do
  source ".Renviron"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end
# .Rprofile
template "#{home}/.Rprofile" do
  source "Rprofile.erb"
  owner "vagrant"
  group "vagrant"
  variables cransite: node[:r31bioc214][:cransite]
  mode "0644"
end

# R user library directory
directory "#{home}/R/library" do
  owner "vagrant"
  group "vagrant"
  recursive true
  mode "0755"
  action :create
end

# Bioconductor install script
cookbook_file "#{home}/installBioconductor.R" do
  source "installBioconductor.R"
  owner "vagrant"
  group "vagrant"
  mode "0755"
end

# install Bioconductor
execute "install Bioconductor" do
  command "R CMD BATCH #{home}/installBioconductor.R"
  action :run
end
