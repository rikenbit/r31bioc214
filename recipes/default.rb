package "apt"
#
apt_repository "rrepository" do
  uri "http://cran.md.tsukuba.ac.jp/bin/linux/ubuntu"
  distribution "precise/"
  #components ["all"]
  keyserver "keyserver.ubuntu.com"
  key "E084DAB9"
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end
package "r-base"

# R version check script
cookbook_file '/home/vagrant/showversion.R' do
  source "showversion.R"
  owner "vagrant"
  group "vagrant"
  mode "0755"
end
# Bioconductor version check script
cookbook_file '/home/vagrant/showBioconductorVersion.R' do
  source "showBioconductorVersion.R"
  owner "vagrant"
  group "vagrant"
  mode "0755"
end

# .Renviron
cookbook_file '/home/vagrant/.Renviron' do
  source ".Renviron"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end
# .Rprofile
cookbook_file '/home/vagrant/.Rprofile' do
  source ".Rprofile"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end

# R user library directory
directory "/home/vagrant/R/library" do
  owner "vagrant"
  group "vagrant"
  recursive true
  mode "0755"
  action :create
end

# Bioconductor install script
cookbook_file '/home/vagrant/installBioconductor.R' do
  source "installBioconductor.R"
  owner "vagrant"
  group "vagrant"
  mode "0755"
end

# install Bioconductor
execute "install Bioconductor" do
  command "R CMD BATCH /home/vagrant/installBioconductor.R"
  action :run
end
