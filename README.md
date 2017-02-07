# be-rail

## Overview

This Qt5 program shows you a list of all the stations of the
Belgian Railways with their telegraphic codes.

This project is licensed under the terms of the [GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)
or any later version. See the LICENSE file for the full text of the license.

Homepage: https://github.com/linuxunderground/be-rail


## Source of database

The data are automatically extracted from Paul Kevers website :   
http://users.telenet.be/pk/stations.htm   
http://users.telenet.be/pk/lijnen.htm   
   
See scripts/build-db.sh


## Compiling sources

Linux compilation:   
   
$ cmake .  
($ cmake -DCMAKE_BUILD_TYPE=Debug .  if you want debug build)  
($ cmake -DDATADIR=../db .  if you want to start be-rail from build directory without installation)  
$ make   
$ sudo make install   
   
   
Windows(tm) compilation:
   
I used [Qt 5.7.1 for Windows 32-bit (MinGW 5.3.0, 1.1 GB)](https://www.qt.io/download-open-source/)
to compile be-rail on Windows:   
   
C:\be-rail> cmake -G "MinGW Makefiles" .   
C:\be-rail> mingw32-make  
  
If you created a dynamically linked executable (default), you will need to run
this command to provide the required dll with the executable :  
  
C:\be-rail> cd build  
C:\be-rail\build> windeployqt --release --no-opengl-sw --no-translations be-rail.exe  
  
Unlike linux version, the database must be in a db subdirectory.
