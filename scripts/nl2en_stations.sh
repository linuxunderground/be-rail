#!/bin/bash
#
# Dutch to English - stations table
#
# Copyright (C) 2017-2018  be-rail@linuxunderground.be
# Distributed under the terms of the GNU General Public License v3
#


# To be sure that sed will behave as expected :
export LC_COLLATE="C"

STATIONS_CSV="$(dirname $0)/../db/stations.csv"

sed -i \
  -e 's/verwijst de code FCV misschien naar/The FCV code may refer to/2' \
  -e 's/werkbasis en noodperron bij/workplace and emergency on/2' \
  -e 's/Franse benaming/French denomination/2' \
  -e 's|in december 2002 omgedoopt in Spa-Géronstère en van een code voorzien / zie aldaar|Renamed Spa-Géronstère in December 2002 and provided with the intended code (FSSG)|2' \
  -e 's/verbindingswissels en uitwijkspoor op/emergency siding on/2' \
  -e "s|tot dec. 2002 / had geen code|no code before december 2002|2" \
  -e 's/-Strand/-Beach/3' \
  -e 's/Kaai/Pier/2' \
  -e 's/uitwijkspoor en noodperron op/emergency siding and workplace on/2' \
  -e 's/Vorming/Formation/2' \
  -e 's/goederenstation/freight station/2' \
  -e 's/nieuwe stopplaats vanaf 10 juni 2001/new station from 10 June 2001/2' \
  -e "s/tot 11 juni 2017/until 11 june 2017/2" \
  -e 's/zie/see/2' \
"$STATIONS_CSV"

# 's/-Strand/-Beach/3' : why 3 ? because Strand is a second time present for german
