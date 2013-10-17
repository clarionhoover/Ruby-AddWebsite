#!/usr/bin/env ruby
###################################################
#  Author: Randy Hoover <randy.hoover@gmail.com>  #
#  Date Created:  2013-10-14                      #
#  Last Modified: 2013-10-17                      #
###################################################

# HighLine for making prompting easier
require 'highline/import'

# check to see if we're running as root
raise 'Must run as root' unless Process.uid ==0

# define method to see if user exists
def user_exists(username)
	username.strip
	username.downcase
	File.directory? "/home/#{username}"
end

def site_exists(username,hostname,tld)
	hostname.strip
	hostname.downcase
	tld.strip
	tld.downcase
	# check to see if user already has a folder and error if folder exists
	if (File.directory? "/home/#{username}/webroot/#{hostname}.#{tld}" == true)
	    puts "Folder exists for user #{username} and website #{hostname}.#{tld} please delete or pick a new hostname"
	    exit
	end
	# then check to see if there's already an apache configuration for the site
	if (File.file? "/etc/apache2/sites-available/#{hostname}.#{tld}.conf" == true)
	    puts "Configuration file exists for website #{hostname}.#{tld} please delete or pick new hostname"
	    exit
	end
end

username = ask "Username of the account the website will go under: "
hostname = ask "Hostname without tld (ie clarionhoover test.clarionhoover): "
tld = ask "TLD for hostname (ie com co org without the .): "

# kill the script if user doesn't exist
if (user_exists(username) == false)
    puts "User doesn't exist, please create user"
    exit
end
