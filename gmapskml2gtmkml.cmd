@echo off
goto :debut
11/06/2015  23:01               254 gmapskml2gtmkml.cmd
# windows cmdline script
convertit un kml de https://maps.google.com/locationhistory/b/0
en un kml lisible par gps trackmaker

#prérequis : utilitaire SED (ici dans sa version ssed)
#ATTENTION l'horodatage des tracés est perdu
#USAGE %0 [file.kml] => produit un file.gtm.kml dans le même dossier
:debut
ssed -e "s/<gx:Track>/<linestring><coordinates>/" -e "s/<\/gx:Track>/<\/coordinates><\/linestring>/" -e "/<when>/d" -e "s/<gx:coord>\([0-9]*\.[0-9]*\) \([0-9]*\.[0-9]*\) \([0-9]*\)<\/gx:coord>/\t\1,\2,\3/" %1 >%1.gtm.kml
