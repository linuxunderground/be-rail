#!/bin/bash
#
# Dutch to German
#
# Copyright (C) 2016-2017  be-rail@linuxunderground.be
# Distributed under the terms of the GNU General Public License v3
#
# Thanks to Claude, Alexandre and PPL (from ICFB) for translation.
#

# To be sure that sed will behave as expected :
export LC_COLLATE="C"


sed \
  -e 's/grens/grenze/g' \
  -e 's/verwijst de code FCV misschien naar/abkürzung FCV verweist wahrscheinlich nach/' \
  -e "s/werkbasis en noodperron bij HSL/arbeitstelle und hilfbahnsteig von NBS/" \
  -e 's/Franse benaming/Französische bezeichnung/' \
  -e 's|in december 2002 omgedoopt in Spa-Géronstère en van een code voorzien / zie aldaar|in Dez.2002 in Spa-Géronstère umbenennt und mit einer abkürzung versehen : siehe dort (FSSG)|' \
  -e "s/verbindingswissels en uitwijkspoor op HSL/verbindungs und abstellgleisweiche auf NBS/" \
  -e "s|tot dec. 2002 / had geen code|bis Dez.2002; hat kein abkürzung|" \
  -e 's/-Strand/-Strand/' \
  -e 's/Kaai/Kai/' \
  -e "s/uitwijkspoor en noodperron op HSL/abstellgleis und behelfsbahnsteig auf NBS/" \
  -e 's/Vorming/Rangierbahnhof/' \
  -e 's/goederenstation/güterbahnhof/' \
  -e "s/nieuwe stopplaats vanaf 10 juni 2001/neue haltestelle ab dem 10. Juni 2001/" \
  -e 's/zie/siehe/g'


# Note:
#
# Equivalence of HSL/LGV ?
#
# NBS for "Neubaustrecke" is usually used which corresponds literally to
# "new line" : https://de.wikipedia.org/wiki/Neubaustrecke
#
# NBS is not strictly synonymous with LGV but will be easier to read
# that "hochgeschwindigkeitslinie" fully spelled out.
