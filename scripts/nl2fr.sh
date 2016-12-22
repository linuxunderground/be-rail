#!/bin/bash
#
# Dutch to French
#
# Copyright (C) 2016  be-rail@linuxunderground.be
# Distributed under the terms of the GNU General Public License v3
#


# To be sure that sed will behave as expected :
export LC_COLLATE="C"


sed \
  -e 's/grens/frontière/g' \
  -e 's/zie/voir/g' \
  -e 's/verwijst de code FCV misschien naar/Le code FCV se réfère peut-être à/' \
  -e "s/werkbasis en noodperron bij HSL/base de travail et plate-forme d'urgence sur/" \
  -e 's/Franse benaming/dénomination française/' \
  -e 's/in december 2002 omgedoopt in Spa-Géronstère en van een code voorzien; zie aldaar/rebaptisé en Spa-Géronstère en décembre 2002 et muni du code prévu (FSSG)/' \
  -e "s/verbindingswissels en uitwijkspoor op HSL/Aiguilles de connection et voie d'évitement sur LGV/" \
  -e "s/tot dec. 2002; had geen code/pas de code avant décembre 2002/" \
  -e 's/-Strand/-Plage/' \
  -e 's/Kaai/Quai/' \
  -e "s/uitwijkspoor en noodperron op HSL/voie d'évitement et plate-forme d'urgence sur LGV/" \
  -e 's/Vorming/Formation/' \
  -e 's/goederenstation/gare de marchandises/' \
  -e "s/nieuwe stopplaats vanaf 10 juni 2001/nouveau point d'arrêt à partir du 10 juin 2001/"
