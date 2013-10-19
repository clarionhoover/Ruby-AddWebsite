#!/usr/bin/env ruby
###################################################
#  Author: Randy Hoover <randy.hoover@gmail.com>  #
#  Date Created:  2013-10-14                      #
#  Last Modified: 2013-10-18                      #
###################################################

# HighLine for making prompting easier, ipaddress for ip checking
require 'highline/import'

# check to see if we're running as root
raise 'Must run as root' unless Process.uid ==0

# define method to "sanitize" our inputed information
def sanitize_text(text)
	text.gsub(/\s+/,"")
	text.downcase
end

# define method to see if user exists
def user_exists(username)
	username = sanitize_text(username)
	File.directory? "/home/#{username}"
end

# method for checking to see if the site exists either in the form of a directory
# in in the form of an apache virtualhost
def site_exists(username,hostname,tld)
	# strip out all the junk and make sure everything is lowercase
	hostname = sanitize_text(hostname)
	tld = sanitze_text(tld)

	# check to see if user already has a folder and error if folder exists
	if (File.directory? "/home/#{username}/webroot/#{hostname}.#{tld}" == true)
	    abort("ERROR: Folder exists for user #{username} and website #{hostname}.#{tld} please delete or pick a new hostname")
	end

	# then check to see if there's already an apache configuration for the site
	if (File.file? "/etc/apache2/sites-available/#{hostname}.#{tld}.conf" == true)
	    abort("ERROR: Configuration file exists for website #{hostname}.#{tld} please delete or pick new hostname")
	end
end

username = ask "Username of the account the website will go under: "

# kill the script if user doesn't exist
if (user_exists(username) == false)
    abort("EROR: User doesn't exist, please create user")
end

hostname = ask "Hostname without tld (ie clarionhoover test.clarionhoover): "
tld = ask "TLD for hostname (ie com co org without the .): "
