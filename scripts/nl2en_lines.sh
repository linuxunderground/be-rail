#!/bin/bash
#
# Dutch to English - lines table
#
# Copyright (C) 2017-2018  be-rail@linuxunderground.be
# Distributed under the terms of the GNU General Public License v3
#


# To be sure that sed will behave as expected :
export LC_COLLATE="C"

LINES_CSV="$(dirname $0)/../db/lines.csv"

sed -i \
  -e 's/grens/border/2' \
"$LINES_CSV"
