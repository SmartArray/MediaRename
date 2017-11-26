# Rename script for images
This script is useful if you want to merge images of two different devices into one single directory.
Using this script you won't probably have filename conflicts. Plus: The filenames are sortable according to their dates.

Example: 
./IMG_3128.JPG -> ./20171109_032037.JPG

Note:
20171109_032037 is the exif recording date of the picture. 

## Install exiftool
#### Mac OS X example:
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
