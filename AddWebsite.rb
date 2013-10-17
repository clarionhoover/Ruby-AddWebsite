#!/usr/bin/env ruby
###################################################
#  Author: Randy Hoover <randy.hoover@gmail.com>  #
#  Date Created:  2013-10-14                      #
#  Last Modified: 2013-10-14                      #
###################################################

# check to see if we're running as root
raise 'Must run as root' unless Process.uid ==0

# define method to see if user exists
def user_exists(username)
	username.strip
	username.downcase
	File.directory? "/home/{username}"
end

def site_exists(hostname,tld)
	hostname.strip
	hostname.downcase
	tld.strip
	tld.downcase
end
