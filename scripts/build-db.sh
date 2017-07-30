#!/bin/bash
#
# Build be-rail sqlite database
#
# Copyright (C) 2016-2017  be-rail@linuxunderground.be
# Distributed under the terms of the GNU General Public License v3
#


DB="be-rail.sqlite"

STATIONS_CSV="stations.csv"
LINES_CSV="lines.csv"


# create sqlite DB

if [ -f "$DB" ]
then
  rm $DB
fi

echo " \
CREATE TABLE stations ( \
regkey integer primary key, \
line varchar(5), \
OOS char(1) COLLATE NOCASE, \
station varchar(40) COLLATE NOCASE, \
code varchar(5), \
oldcode varchar(5), \
note_nl varchar(50), \
note_fr varchar(50), \
note_de varchar(50), \
note_en varchar(50) \
); \
CREATE TABLE lines ( \
number varchar(5) primary key, \
name_nl varchar(60), \
name_fr varchar(60), \
name_de varchar(60), \
name_en varchar(60) \
); \
" | sqlite3 "$DB"


# build csv files

./web2csv.sh "$STATIONS_CSV" "$LINES_CSV"


# add translations
# WARNING: do not change call order !!!
./nl2fr_stations.sh
./nl2fr_lines.sh
./nl2de_stations.sh
./nl2de_lines.sh
./nl2en_stations.sh
./nl2en_lines.sh


# import stations

cat "$STATIONS_CSV" | \
sqlite3 -csv "$DB" ".import /dev/stdin stations"


# import lines

cat "$LINES_CSV" | \
sqlite3 -csv "$DB" ".import /dev/stdin lines"
