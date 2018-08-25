#!/bin/bash
#
# Grab be-rail data from Paul Kevers website
#
# Copyright (C) 2016-2018  be-rail@linuxunderground.be
# Distributed under the terms of the GNU General Public License v3
#


# To be sure that sed will behave as expected :
export LC_COLLATE="C"

SCRIPT=$(dirname $0)
CACHE="${SCRIPT}/../cache"
DBDIR="${SCRIPT}/../db"

WEBSITE="http://users.telenet.be/pk/"
STATIONS="stations.htm"
LINES="lijnen.htm"

STATIONS_CSV="stations.csv"
LINES_CSV="lines.csv"


# Grab stations

if [ ! -f "${CACHE}/${STATIONS}" ]
then
    wget -P "${CACHE}" "${WEBSITE}${STATIONS}"
fi

# remove "-e 's|n-a||g' \" if you want "n-a" in empty cells
cat "${CACHE}/${STATIONS}" | grep "^[0-9]" | grep -v "^...[0-9]" | \
  sed \
    -e 's|<[^<]*>||g' \
    -e 's/\&quot;/"/g' \
    -e 's/\&amp;/\&/g' \
    -e 's/\&lt;/</g' \
    -e 's/\&gt;/>/g' \
    -e 's/\&agrave;/à/g' \
    -e 's/\&acirc;/â/g' \
    -e 's/\&ccedil;/ç/g' \
    -e 's/\&eacute;/é/g' \
    -e 's/\&euml;/ë/g' \
    -e 's/\&Eacute;/É/g' \
    -e 's/\&egrave;/è/g' \
    -e 's/\&ecirc;/ê/g' \
    -e 's/\&icirc;/î/g' \
    -e 's/\&ouml;/ö/g' \
    -e 's/\&ocirc;/ô/g' \
    -e 's/\&uuml;/ü/g' \
    -e 's/\&ucirc;/û/g' \
    -e 's|;| /|g' \
    -e 's|Zilverberg.*|Zilverberg: zie Den Aap|' \
    -e 's|: zie|,zie|' \
    -e 's|\[S|S|' \
    -e '/FCV/! s|\]$||' \
    -e 's|HSL|hslxxx|;s|FCV|fcvxxx|2' \
    -e 's|\([A-Z]\{2,4\}\)|,\1#1,|1' \
    -e 's|\([A-Z]\{2,4\}\)|,\1#2,|2' \
    -e '/,zie/ s|,|,n-a,n-a,|;/,zie/ s|$|,|' \
    -e '/,$/! s|$|,n-a,n-a,|' \
    -e '/#2/! s|#1|,n-a|' \
    -e 's|#1||;s|#2||' \
    -e 's|[[:space:]]\{1,\}|,|' \
    -e 's|[[:space:]]\{1,\},|,|' \
    -e 's|,[[:space:]]\{1,\},|,|' \
    -e '/*/! s|,|,N,|' \
    -e '/*/s|,\*|,O,|' \
    -e 's|,HS,| HS,|' \
    -e 's|,HSL,|HSL|' \
    -e 's|,[[:space:]]\{1,\}|,|g' \
    -e 's|[[:space:]]\{4,\}|#3|' \
    -e '/#3/ s|,n-a,n-a,,||;s|#3|,n-a,n-a,|' \
    -e '/[A-Z]\{2,4\},n-a,/ s|,n-a,n-a,||' \
    -e '/[A-Z]\{2,4\},[A-Z]\{2,4\},/ s|,n-a,n-a,||' \
    -e 's|hslxxx|HSL|;s|fcvxxx|FCV|' \
    -e '/Géronstère (in/ s|Géronstère |Géronstère,n-a,n-a,|' \
    -e 's|FNDM,F|FNDMF|' \
    -e 's|,n-a,n-a,||2' \
    -e '/,$/! s|$|,|' \
    -e 's|$|,|' | cat -n | sed \
    -e 's|n-a||g' \
    -e 's|[[:space:]]\{1,\}||' \
    -e 's|[[:space:]]\{1,\}|,|' | \
awk -F"," '{print $1","$2","$3","$4","$5","$6","$7","$7","$7","$7}' > "${DBDIR}/${STATIONS_CSV}"


# Grab lines

if [ ! -f "${CACHE}/${LINES}" ]
then
    wget -P "${CACHE}" "${WEBSITE}${LINES}"
fi

cat "${CACHE}/${LINES}" | grep '^<B>[0-9]' | \
  sed \
    -e 's|</B>  |,|' \
    -e 's|<[^<]*>||g' \
    -e 's/\&amp;/\&/g' \
    -e 's/\&pound;/£/g' \
    -e 's/\&middot;/·/g' \
    -e 's/\&lt;/</g' \
    -e 's/\&gt;/>/g' \
    -e 's/\&agrave;/à/g' \
    -e 's/\&acirc;/â/g' \
    -e 's/\&ccedil;/ç/g' \
    -e 's/\&eacute;/é/g' \
    -e 's/\&eacute/é/g' \
    -e 's/\&egrave;/è/g' \
    -e 's/\&ecirc;/ê/g' \
    -e 's/\&icirc;/î/g' \
    -e 's/\&uuml;/ü/g' \
    -e 's/\&ocirc;/ô/g' | \
awk -F"," '{print $1","$2","$2","$2","$2}' > "${DBDIR}/${LINES_CSV}"

cat "${CACHE}/${LINES}" | sed -e 's:\xB0:°:' | grep -a '^<DT>' | \
  sed \
    -e 's|</FONT>|,|' \
    -e 's|<BR>*$||' \
    -e 's|<[^<]*>||g' \
    -e '/260/ s/(140).*$/(140)/ ; s/(in.*4) //' \
    -e '/289/ s/ (na.*$//' \
    -e '/220\*/ d' \
    -e '/231\*/ d' \
    -e '/280\*/ d' \
    -e 's|\*,|,|' \
    -e 's/\&amp;/\&/g' \
    -e 's/\&euml;/ë/g' \
    -e 's/&Eacute;/Ë/g' \
    -e 's/&ecirc;/ê/g' \
    -e 's/\&eacute;/é/g' | \
awk -F"," '{print $1","$2","$2","$2","$2}' >> "${DBDIR}/${LINES_CSV}"
