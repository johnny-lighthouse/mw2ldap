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

#declare hash to hold user / group info
my %groupshash = (); #not named groups to differentiate from $group variable

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
		
		#add line info to hash
		$groupshash{$username} = $group unless exists $groupshash{$username} ;

	   }

	#indicate completion of loop
	#print "\n\n";

    }

#print hash of user and group as check
my $key;
#foreach $key (keys %groupshash) {
# 	 print "Key: $key, Value: \$$groupshash{$key}\n"; }


#create new hash of group and memebrs
my %uniquegroups;
foreach $key ( keys %groupshash ) {
	push @{ $uniquegroups{ $groupshash{$key} } }, $key; }

#false start
#my $value;
#while (($key, $value) = each %uniquegroups) {
#	
#	#print key
#	print "key= $key\n";
#	
#	#print each member of value array
#
#   }

#print hash of group / members
foreach $key (keys %uniquegroups) {
	print "members of group $key are:\n"; 
	foreach (@{$uniquegroups{$key}}) {
 	 	print "\t$_\n"; }
            }

#create ldif print for each group key with contents of value array as member records

#close open files and any other cleanup
close (DATAFILE);
