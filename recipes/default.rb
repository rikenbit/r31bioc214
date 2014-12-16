#case node.platform
#when 'ubuntu', 'debian'
#  include_recipe "ubuntu-change-source-list"
#  include_recipe "apt"
#  package "apt"
#  #
#  apt_repository "rrepository" do
#    uri "#{node['r31bioc214']['Rapturl']}"
#    distribution "precise/"
#    keyserver "keyserver.ubuntu.com"
#    key "E084DAB9"
#    action :add
#    notifies :run, "execute[apt-get update]", :immediately
#  end
#  package "r-base"
#when 'centos'
#  include_recipe "yum"
#  package "yum"
#  # add the EPEL repo
#  yum_repository 'epel' do
#    description 'Extra Packages for Enterprise Linux'
#    mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch'
#    gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
#    action :create
#  end
#  package "R"
#end

# home directory
#home = "/home/"+node[:current_user]
home = "/home/vagrant"

# R version check script
cookbook_file "#{home}/showversion.R" do
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
#
#
r_prefix_path = ""
if node[:r31biocdev].has_key?('r_prefix_path')
  if node[:r31biocdev][:r_prefix_path] != nil
    r_prefix_path = node[:r31biocdev][:r_prefix_path]
  end
end


# install Bioconductor
execute "install Bioconductor" do
  command "#{r_prefix_path}R CMD BATCH #{home}/installBioconductor.R"
  action :run
end
