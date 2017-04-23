#!/bin/bash
#
# Build be-rail sqlite database
#
# Copyright (C) 2016-2017  be-rail@linuxunderground.be
# Distributed under the terms of the GNU General Public License v3
#


DBEN="be-rail.sqlite"
DBFR="be-rail-fr.sqlite"
DBNL="be-rail-nl.sqlite"
DBGE="be-rail-ge.sqlite"

STATIONS_CSV="stations.csv"
LINES_CSV="lines.csv"


# create sqlite DB

if [ -f "$DBEN" ]
then
  rm $DBEN
fi

if [ -f "$DBFR" ]
then
  rm $DBFR
fi

if [ -f "$DBNL" ]
then
  rm $DBNL
fi

if [ -f "$DBGE" ]
then
  rm $DBGE
fi

echo " \
CREATE TABLE stations ( \
regkey integer primary key, \
line varchar(5), \
OOS char(1) COLLATE NOCASE, \
station varchar(40) COLLATE NOCASE, \
code varchar(5), \
oldcode varchar(5), \
remark varchar(50) \
); \
CREATE TABLE lines ( \
number varchar(5) primary key, \
name varchar(60) \
); \
" | sqlite3 "$DBEN"

cp "$DBEN" "$DBFR"
cp "$DBEN" "$DBNL"
cp "$DBEN" "$DBGE"


# build csv files

./web2csv.sh "$STATIONS_CSV" "$LINES_CSV"


# import stations

cat "$STATIONS_CSV" | \
sqlite3 -csv "$DBNL" ".import /dev/stdin stations"

cat "$STATIONS_CSV" | ./nl2fr.sh | \
sqlite3 -csv "$DBFR" ".import /dev/stdin stations"

cat "$STATIONS_CSV" | ./nl2en.sh | \
sqlite3 -csv "$DBEN" ".import /dev/stdin stations"

cat "$STATIONS_CSV" | ./nl2ge.sh | \
sqlite3 -csv "$DBGE" ".import /dev/stdin stations"

# import lines

cat "$LINES_CSV" | \
sqlite3 -csv "$DBNL" ".import /dev/stdin lines"

cat "$LINES_CSV" | ./nl2fr.sh | \
sqlite3 -csv "$DBFR" ".import /dev/stdin lines"

cat "$LINES_CSV" | ./nl2en.sh | \
sqlite3 -csv "$DBEN" ".import /dev/stdin lines"

cat "$LINES_CSV" | ./nl2ge.sh | \
sqlite3 -csv "$DBGE" ".import /dev/stdin lines"
