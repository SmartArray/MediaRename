#!/usr/bin/perl

my $OFFSET = -7*60*60;

use File::Basename;
use Data::Dumper;
#use POSIX 'strftime';
use DateTime::Format::Strptime;
use Date::Format;

#print localtime() . "\n";
#print strftime "%Y%m%d_%H%M%S\n", localtime();

sub renameFile {
	my $filename = shift;
	my $new_slow_motion_filename = "";
	my $old_slow_motion_filename = "";

	if (-d $filename) { return; }

	my $command = "exiftool -modifyDate \"$filename\" ";
	my $output = `$command`;

	if ($output eq "") { print "[WARN] File $filename does not have an EXIF date.\n"; return ""; }

	if (($output =~ m/No file/)) {
		print "[WARN] File $filename not existing.\n";
	} else {
		my @sp = split /:/, $output, 2;
		my $date = @sp[1];
		$date =~ s/^\s+|\s+$//g;
		
		my $parser = DateTime::Format::Strptime->new( pattern => '%Y:%m:%d %H:%M:%S' );
		my $dt = $parser->parse_datetime($date);

		my $newdate =  ($dt->epoch + $OFFSET);
		my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime($newdate);

		my $ren = time2str("%Y%m%d_%H%M%S", $newdate);

		my $newFilename = dirname($filename) . "/" . $ren;		

		my ($name, $path, $suffix) = fileparse($filename, '\.[^\.]*');

		# skip slow motion files
		next if uc($suffix) eq "AAE";

		# exit if already correct name
		return if (($newFilename . $suffix) eq $filename);

		my $temp = $newFilename;
		my $i = 0;
		while (-e ($newFilename . $suffix)) {
			$i++;
			$newFilename = $temp . "_" . $i;
		}

		#check if slow motion file exists
		$old_slow_motion_filename = $path . $name . ".AAE";
		if (-f $old_slow_motion_filename) {
			$new_slow_motion_filename = $newFilename . ".AAE";
		}

		# append suffix
		$newFilename .= $suffix;

		# print status
		print $filename . " -> " . $newFilename . "\n";

		# rename file
		rename $filename, $newFilename;

		if ($new_slow_motion_filename ne "") {
			# rename slow motion file
			print $old_slow_motion_filename . " -> " . $new_slow_motion_filename . "\n";
			rename $old_slow_motion_filename, $new_slow_motion_filename;
		}
	}
}

foreach (@ARGV) {
	renameFile($_);
}
