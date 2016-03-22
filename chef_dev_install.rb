#!/usr/bin/ruby
# =====================================================================================================================
# Description: *DRAFT* Mac OS installer of software needed to develop Chef cookbooks
# Usage: "ruby chef_dev_install"
# File Path: chef_dev_install.rb
# =====================================================================================================================

require "fileutils"

class String
  def bold;   "\033[1m#{self}\033[22m"; end
  def brown;  "\033[33m#{self}\033[0m"; end
  def cyan;   "\033[36m#{self}\033[0m"; end
  def green;  "\033[32m#{self}\033[0m"; end
  def red;    "\033[31m#{self}\033[0m"; end
  def yellow; "\033[93m#{self}\033[0m"; end
end

chef_home_directory = File.join(ENV["HOME"], ".chef")
chef_server = "CHEF_SERVER_FQDN_GOES_HERE"
knife_config_file = File.join(chef_home_directory, "knife.rb")
user_name = ENV["USER"].split("@").first

#TODO: Install homebrew and cask etc.; exit if not installed
puts "This script assumes you have ruby, homebrew and cask installed".cyan

puts "\nUpdating Homebrew".yellow
`brew update`

puts "\nInstalling VirtualBox".yellow
puts `brew cask install virtualbox`

puts "\nInstalling Vagrant".yellow
puts `brew cask install vagrant`

puts "\nInstalling Vagrant Manager".yellow
puts `brew cask install vagrant-manager`

puts "\nInstalling ChefDK".yellow
puts `brew cask install chefdk`

puts "\nInstalling vagrant plugins".yellow
puts `vagrant plugin install vagrant-berkshelf`
puts `vagrant plugin install vagrant-omnibus`

puts "\nCreating #{chef_home_directory}".yellow
FileUtils.mkdir_p chef_home_directory

puts "\nCreating #{knife_config_file}".yellow
if File.file?(knife_config_file)
  puts "#{knife_config_file} already exists. Skipping.".yellow
else
  knife = <<-KNIFE
# See http://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

log_level                :info
log_location             STDOUT
node_name                "#{user_name}"
client_key               "#{chef_home_directory}/#{user_name}.pem"
validation_client_name   "emf-validator"
validation_key           "#{chef_home_directory}/emf-validator.pem"
chef_server_url          "https://#{chef_server}/organizations/emf"
cache_type               "BasicFile"
cache_options( path: "#{chef_home_directory}/checksums" )
cookbook_path            ["#{FileUtils.pwd}/cookbooks"]
KNIFE
  File.write(knife_config_file, knife)
end

config_json = File.join(ENV["HOME"], ".berkshelf", "config.json")
puts "\nCreating Berkshelf config".yellow
if File.file?(config_json)
  puts "\texists. Skipping.".yellow
else
  config = <<-CONFIG
{
  "ssl" : {
    "verify" : false
  }
}
CONFIG
  File.write(config_json, config)
end

puts "Chef development tool installation complete".yellow

puts %(\n\nAcquire the "emf-validator.pem" organization key file and store at "#{chef_home_directory}/emf-validator.pem").cyan
puts %(Acquire your "#{user_name}.pem" user key file and store at "#{chef_home_directory}/#{user_name}.pem").cyan

# Run the following fix to disable the default VirtualBox DHCP server (if error):
# https://github.com/mitchellh/vagrant/issues/3083
#   VBoxManage dhcpserver remove --netname HostInterfaceNetworking-vboxnet0
