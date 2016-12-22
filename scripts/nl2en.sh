#!/bin/bash
#
# Dutch to English
#
# Copyright (C) 2016  be-rail@linuxunderground.be
# Distributed under the terms of the GNU General Public License v3
#


# To be sure that sed will behave as expected :
export LC_COLLATE="C"


sed \
  -e 's/grens/border/g' \
  -e 's/zie/see/g' \
  -e 's/verwijst de code FCV misschien naar/The FCV code may refer to/' \
  -e 's/werkbasis en noodperron bij/workplace and emergency on/' \
  -e 's/Franse benaming/French denomination/' \
  -e 's/in december 2002 omgedoopt in Spa-Géronstère en van een code voorzien; zie aldaar/Renamed Spa-Géronstère in December 2002 and provided with the intended code (FSSG)/' \
  -e 's/verbindingswissels en uitwijkspoor op/emergency siding on/' \
  -e "s/tot dec. 2002; had geen code/no code before december 2002/" \
  -e 's/-Strand/-Beach/' \
  -e 's/Kaai/Pier/' \
  -e 's/uitwijkspoor en noodperron op/emergency siding and workplace on/' \
  -e 's/Vorming/Formation/' \
  -e 's/goederenstation/freight station/' \
  -e 's/nieuwe stopplaats vanaf 10 juni 2001/new station from 10 June 2001/'
