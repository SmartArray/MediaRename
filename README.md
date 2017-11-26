# Rename script for images
## Install exiftool
### Mac OS X example:
```bash
	cd /tmp && wget https://www.sno.phy.queensu.ca/~phil/exiftool/ExifTool-10.67.dmg && open `basename !$` && cd -
```

## Install strptime for perl
using cpan or the submodules in the modules directory.

Installing a module via shipped tgz files is as easy as follows
- Untar the archive
- run:
```bash
	perl Makefile.PL
	make
	make test
	make install
```

## running the script
In a directory with many files run the script as follows:
```bash
	./rename.pl *.JPG
	./rename.pl *.MOV # should also rename the AAE (iOS timelapse information files)
```
