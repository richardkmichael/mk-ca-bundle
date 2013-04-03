use MIME::Base64;

my $txt = "thawte_ca_octal.txt";
open(TXT,"$txt") or die "Couldn't open $txt: $!\n";

my $data;
while (<TXT>) {
  last if (/^END/);
  chomp;
  my @octets = split(/\\/);
  shift @octets;
  for (@octets) {
    $data .= chr(oct);
  }
}

# my $encoded = pMIME::Base64::encode($data);
my $encoded = MIME::Base64::encode_base64($data, '');
$encoded =~ s/(.{1,64})/$1\n/g;

my $pem = "-----BEGIN CERTIFICATE-----\n"
        . $encoded
        . "-----END CERTIFICATE-----\n";

print $pem
