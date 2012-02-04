#! /usr/bin/perl
#

print "\n\n\n";

#known passwd hash from mediawiki mysql.  this is what we are trying to recreate
my $hash;
$hash = 'ca0bf9b6a7394f189d7c0e37d56f1920';

#known input to above hash from mediawiki
my $secret;
$secret = 'uGCDT7d';
#alternate for testing
#$secret = 'password';

my $salt;
$salt = 'e5fbc99e';
#alternate for mediawiki password example
#$salt = '838c83e1';
#print 'salt is: ' . $salt . "\n";

#attempt conversion of salt to different encoding
#not useful
#$salt = pack('a*',$salt);
#print 'salt is now: ' . $salt . "\n";

use Digest::MD5;
use MIME::Base64;

#
# NB hash variables $sty, $ctx, and $dtz are meaningless adoptions from an example i followed
#

#initial simple hash of secret 
$sty = Digest::MD5->new;
$sty->add($secret);
#print 'secret is :' . $secret . "\n";
my $firsthash;
$firsthash = $sty->hexdigest;
#print 'simple hash of secret in hex encoding is: ' . $firsthash . "\n";

#rehash simple hash with salt, mediawiki style
$ctx = Digest::MD5->new;
$ctx->add($salt);
$ctx->add('-');
$ctx->add($firsthash);

#binary version for comparison
#$hashedPasswd= $ctx->clone->digest;
#print 'md5 binary hash is: ' . $hashedPasswd . "\n";

#produce hex encoded mediawiki sytle hash of secret and salt
$digest = $ctx->hexdigest;
#use below to verify that we are producing same outputs on given inputs as mediawiki
#print 'generated hash:       ' . $digest . "\n";
#print 'known mediawiki hash: ' . $hash . "\n";
#if these match then we have demonstrated understanding of mediawiki process

#hash ldap style
$dtz = Digest::MD5->new;
#$dtz->add($firsthash);
#ldap doesn't work that way.  also omits dash between secret and salt in final hash.
$dtz->add($secret);
$dtz->add($salt);

#convert ldap hash to base 64
$hashedPasswd64 = encode_base64($dtz->digest . $salt ,'');
#print 'md5 base64 hash with salt is: ' .  $hashedPasswd64 . "\n";
print '{SMD5}' . $hashedPasswd64;
#final output above can be fed to ldap and authenticated against to confirm understanding of ldap workings.

