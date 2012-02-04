#!/usr/bin/perl
#
# create ldif file from file containing user info
# output will print to standard out and can be piped somewhere else

use strict;
use warnings;

# open file containing user info

open (DATAFILE, 'pretty_combined');

# loop through by line

while (<DATAFILE>) {

	#clear off newline at end of line string
	#grabed this from example, do i need?
	chomp;

	#print the whole line to demonstrate proper read
	print "$_\n";

	# for each line match username, email, and group
	
	if ($_ =~ /(username) whitespace => whitespace (email) whitespace :B:alphanum:[zero or more non whitespace] whitespace (group name)  /i) #close match, case insensitive, close if paren

	{                     #then block

	my($username) = $1;
	my($email) = $2;
	my($group) = $3

	}                     #close of then 

	#print found variables to verify correct operation
	print "Set username= " . $username . " Set email= " . $email . " Set group= " . $group . "\n";

	# create ldif for user

	# create group if not seen before

	# add user to group if it exists

	#print two extra newlines to indicate completion of loop
	print "\n\n";

	#close while loop
	}


#close open files and any other cleanup

close (DATAFILE);
