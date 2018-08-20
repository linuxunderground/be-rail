#!/bin/bash
#
# Dutch to German - lines table
#
# Copyright (C) 2017-2018  be-rail@linuxunderground.be
# Distributed under the terms of the GNU General Public License v3
#
# Thanks to Claude, Alexandre and PPL (from ICFB) for translation.
#

# To be sure that sed will behave as expected :
export LC_COLLATE="C"

LINES_CSV="$(dirname $0)/../db/lines.csv"

sed -i \
  -e 's/grens/grenze/2' \
"$LINES_CSV"
