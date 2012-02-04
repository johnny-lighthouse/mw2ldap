#!/usr/bin/perl
#
# create ldif file from file containing user info
# we are expecting one record per line with whitespace delimited fields
# we are expecting 'username => email password-hash groupname'
# output will print to standard out and can be piped somewhere else

use strict;
use warnings;

# open file containing user info

open (DATAFILE, 'pretty_combined');

# loop through by line

while (<DATAFILE>) {

	#clear off newline at end of line string
	chomp;

	#print the whole line to demonstrate proper read
	print "$_\n";

	# for each line find username, email, and group
	
	if ($_ =~ /(\w+)\s+=>\s+(\w+@\S+)\s+:B:\w+:\w*\s+(\w+)/i)

		{
		my($username) = $1;
		my($email) = $2;
		my($group) = $3

		}

	#print variables to verify correct operation
	print "Set username= " . $username . " Set email= " . $email . " Set group= " . $group . "\n";

	# create ldif for user

	# create group if not seen before

	# add user to group if it exists

	#indicate completion of loop
	print "end of loop\n\n";

	}


#close open files and any other cleanup

close (DATAFILE);
