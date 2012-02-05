#!/usr/bin/perl
#
# create ldif from file containing user info
# we are expecting one record per line with whitespace delimited fields
# we are expecting 'username => email password-hash groupname'
# output will print to standard out and can be piped somewhere else

use strict;
use warnings;

# open file containing user info
open (DATAFILE, 'user-data.txt');

# loop through by line
while (<DATAFILE>) {

	# print the whole line to demonstrate proper read
	print "$_";

	# initialize variables
	my $username;
	my $email;
	my $group;

	# for each line find username, email, and group
	if ($_ =~ /(\S+)\s+=>\s+(\S+@\S+)\s+:B:\w+:\w*\s+(\w+)/i) {

		#fill variables from pattern match
		$username = $1;
		$email = $2;
		$group = $3;

		#print variables to verify correct operation
		print "Set username= " . $username . " Set email= " . $email . " Set group= " . $group . "\n";

		# create ldif for user
		print "dn: uid=" . $username . ",ou=x,dc=y,dc=z,dc=com\n";
		print "uid: " . $username . "\n";
		print "sn: " . $username . "\n"; 
		print "objectClass: top\n";
		print "objectClass: person\n";
		print "objectClass: inetOrgPerson\n";
		print "mail: " . $email . "\n\n";

		# create group if not seen before
			#can we check to see if $group exists in an interloop persistent data structure (hash, array, etc)
			#if not then add it
		# add user to group if it exists
			#we really want to create group all at once so the memebrs are grouped together in the ldap output
			#can we store dn and group in a persistent structure and create groups after processing all lines?
			#can i use one structure for both?  there an easy way to list unique values in a multi fielded structure?

	   }

	#indicate completion of loop
	#print "\n\n";

    }

#close open files and any other cleanup
close (DATAFILE);
