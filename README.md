# be-rail

## Overview

This Qt5 program shows you a list of all the stations of the
Belgian Railways with their telegraphic codes.

This project is licensed under the terms of the [GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)
or any later version. See the COPYING file for the full text of the license.


## Source of database

The data are automatically extracted from Paul Kevers website :   
http://users.telenet.be/pk/stations.htm   
http://users.telenet.be/pk/lijnen.htm   
   
See scripts/build-db.sh


## Compiling sources

Linux compilation:   
   
$ cmake .   
$ make   
$ sudo make install   
   
   
Windows(tm) compilation:
   
FYI only, I had not tested yet. This will probably require yet some hacking of
the CMakeLists.txt. On Windows, using MinGW:   
   
C:\be-rail> cmake -G "MinGW Makefiles" .   
C:\be-rail> make   
