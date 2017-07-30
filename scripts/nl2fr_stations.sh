#!/bin/bash
#
# Dutch to French - stations table
#
# Copyright (C) 2017  be-rail@linuxunderground.be
# Distributed under the terms of the GNU General Public License v3
#


# To be sure that sed will behave as expected :
export LC_COLLATE="C"

STATIONS_CSV="stations.csv"

sed -i \
  -e 's/verwijst de code FCV misschien naar/Le code FCV se réfère peut-être à/2' \
  -e "s/werkbasis en noodperron bij HSL/base de travail et plate-forme d'urgence sur/2" \
  -e 's/Franse benaming/dénomination française/2' \
  -e 's|in december 2002 omgedoopt in Spa-Géronstère en van een code voorzien / zie aldaar|rebaptisé en Spa-Géronstère en décembre 2002 et muni du code prévu (FSSG)|2' \
  -e "s/verbindingswissels en uitwijkspoor op HSL/Aiguilles de connection et voie d'évitement sur LGV/2" \
  -e "s|tot dec. 2002 / had geen code|pas de code avant décembre 2002|2" \
  -e 's/-Strand/-Plage/2' \
  -e 's/Kaai/Quai/2' \
  -e "s/uitwijkspoor en noodperron op HSL/voie d'évitement et plate-forme d'urgence sur LGV/2" \
  -e 's/Vorming/Formation/2' \
  -e 's/goederenstation/gare de marchandises/2' \
  -e "s/nieuwe stopplaats vanaf 10 juni 2001/nouveau point d'arrêt à partir du 10 juin 2001/2" \
  -e "s/tot 11 juni 2017/jusqu'au 11 juin 2017/2" \
  -e 's/zie/voir/2' \
"$STATIONS_CSV"
