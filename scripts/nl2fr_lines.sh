#!/bin/bash
#
# Dutch to French - lines table
#
# Copyright (C) 2017  be-rail@linuxunderground.be
# Distributed under the terms of the GNU General Public License v3
#

# To be sure that sed will behave as expected :
export LC_COLLATE="C"

LINES_CSV="lines.csv"

sed -i \
  -e 's/grens/frontière/2' \
"$LINES_CSV"
