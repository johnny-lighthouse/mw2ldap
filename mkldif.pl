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

#setup variables for use in loop
my $username;
my $email;
my $group;

# loop through by line

while (<DATAFILE>) {

	#clear off newline at end of line string
	chomp;

	#print the whole line to demonstrate proper read
	print "$_\n";

	# for each line find username, email, and group
	
	if ($_ =~ /(\S+)\s+=>\s+(\S+@\S+)\s+:B:\w+:\w*\s+(\w+)/i)

		{
		$username = $1;
		$email = $2;
		$group = $3

		}

	#print variables to verify correct operation
	print "Set username= " . $username . " Set email= " . $email . " Set group= " . $group . "\n";

	# create ldif for user

	print "\n";

	print "dn: uid=" . $username . ",ou=x,dc=y,dc=z,dc=com\n";
	print "uid: " . $username . "\n";
	print "sn: " . $username . "\n"; 
	print "objectClass: top\n";
	print "objectClass: person\n";
	print "objectClass: inetOrgPerson\n";
	print "mail: " . $email . "\n";

	# create group if not seen before

	# add user to group if it exists

	#indicate completion of loop
	print "\n\n";

	}


#close open files and any other cleanup

close (DATAFILE);
