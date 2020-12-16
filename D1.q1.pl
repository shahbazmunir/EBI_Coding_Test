#!/usr/bin/perl
use strict;
use warnings;

#my $filename = "tmp2.xml";
my $filename = "articles_authors.xml";
my $article = "false";
my %hash;
my $title = "";
my %title_hash;
my $name = "";
open(DATA, "$filename") or die "File not found '$filename' $!";
while(<DATA>){
	if($_ =~ m/<Article>/){
		$article = "true";
		next;
	}
	if ($_ =~ m/<\/Article>/){
		$article = "false";
		$name = "";
		next;
	}

	if($article eq "true"){
		if($_ =~ m/<ArticleTitle>/){
			my @title = split("<|>", $_);
			$title = $title[2];
			next;		
		}
		if($_ =~ m/<LastName>/){
			my @arr = split("<|>", $_);
			$name = $arr[2];
			next;
		}
		if($_ =~ m/<ForeName>/){
			my @arr = split("<|>", $_);
			$name = "$name, $arr[2]";
			if(exists $hash{$name}){
				$hash{$name} = $hash{$name} + 1;
			}else{
				$hash{$name} = 1;
			}

			if(exists $title_hash{$title}){
				$title_hash{$title} = "$title_hash{$title};$name";
			}else{
				$title_hash{$title} = $name;
			}
		}
	}

}

my @aa = sort keys %hash;
for(my $x=0; $x< scalar(@aa);$x++){
	if($x == 0){
		foreach my $value (@aa){
			print "\t$value";
		}
		print "\n";
	}
	print "$aa[$x]\t";
	for(my $y=0; $y< scalar(@aa);$y++){
		my $tmp = "0";
		if($x == $y){
			print "$hash{$aa[$x]}\t"
		}else{
			foreach my $key (sort keys %title_hash){
				my @n = split(";", $title_hash{$key});
				if(($n[0] eq $aa[$x] and $n[1] eq $aa[$y]) or ($n[0] eq $aa[$y] and $n[1] eq $aa[$x])){
					$tmp = "1";
				}
			}print "$tmp\t";

		}
		
	}print "\n";
}

=begin
foreach my $key (sort keys %hash){
	print "$key=> $hash{$key}\n";
}

foreach my $key (sort keys %title_hash){
	print "$key=> $title_hash{$key}\n";
}
=cut
