#!/bin/bash
#
# Grab be-rail data from Paul Kevers website
#
# Copyright (C) 2016  be-rail@linuxunderground.be
# Distributed under the terms of the GNU General Public License v3
#


# To be sure that sed will behave as expected :
export LC_COLLATE="C"


WEBSITE="http://users.telenet.be/pk/"
STATIONS="stations.htm"
LINES="lijnen.htm"


# Grab stations

if [ ! -f "$STATIONS" ]
then
    wget "$WEBSITE$STATIONS"
fi

# remove "-e 's|n-a||g' \" if you want "n-a" in empty cells
cat "$STATIONS" | grep "^[0-9]" | grep -v "^...[0-9]" | \
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
    -e 's|,n-a,n-a,||2' \
    -e '/,$/! s|$|,|' | cat -n | sed \
    -e 's|n-a||g' \
    -e 's|[[:space:]]\{1,\}||' \
    -e 's|[[:space:]]\{1,\}|,|' > $1


# Grab lines

if [ ! -f "$LINES" ]
then
    wget "$WEBSITE$LINES"
fi

cat "$LINES" | grep '^<B>[0-9]' | \
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
    -e 's/\&ocirc;/ô/g' > $2
