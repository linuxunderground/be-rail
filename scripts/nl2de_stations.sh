#!/bin/bash
#
# Dutch to German - stations table
#
# Copyright (C) 2017  be-rail@linuxunderground.be
# Distributed under the terms of the GNU General Public License v3
#
# Thanks to Claude, Alexandre and PPL (from ICFB) for translation.
#

# To be sure that sed will behave as expected :
export LC_COLLATE="C"

STATIONS_CSV="stations.csv"

sed -i \
  -e 's/verwijst de code FCV misschien naar/abkürzung FCV verweist wahrscheinlich nach/2' \
  -e "s/werkbasis en noodperron bij HSL/arbeitstelle und hilfbahnsteig von NBS/2" \
  -e 's/Franse benaming/Französische bezeichnung/2' \
  -e 's|in december 2002 omgedoopt in Spa-Géronstère en van een code voorzien / zie aldaar|in Dez.2002 in Spa-Géronstère umbenennt und mit einer abkürzung versehen : siehe dort (FSSG)|2' \
  -e "s/verbindingswissels en uitwijkspoor op HSL/verbindungs und abstellgleisweiche auf NBS/2" \
  -e "s|tot dec. 2002 / had geen code|bis Dez.2002; hat kein abkürzung|2" \
  -e 's/-Strand/-Strand/2' \
  -e 's/Kaai/Kai/2' \
  -e "s/uitwijkspoor en noodperron op HSL/abstellgleis und behelfsbahnsteig auf NBS/2" \
  -e 's/Vorming/Rangierbahnhof/2' \
  -e 's/goederenstation/güterbahnhof/2' \
  -e "s/nieuwe stopplaats vanaf 10 juni 2001/neue haltestelle ab dem 10. Juni 2001/2" \
  -e "s/tot 11 juni 2017/bis zum 11 Juni 2017/2" \
  -e 's/zie/siehe/2' \
"$STATIONS_CSV"


# Note:
#
# Equivalence of HSL/LGV ?
#
# NBS for "Neubaustrecke" is usually used which corresponds literally to
# "new line" : https://de.wikipedia.org/wiki/Neubaustrecke
#
# NBS is not strictly synonymous with LGV but will be easier to read
# that "hochgeschwindigkeitslinie" fully spelled out.
