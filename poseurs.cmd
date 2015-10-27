@echo off
goto :debut
27/10/2015  15:04               662 poseurs.cmd
Donne le nombre de résonateurs posés par chaque joueur sur les portails ingress dont on a relevé les données
#prérequis :
utilitaires gnuwin32
- awk (ici dans sa version gnu gawk)
- sort (renomm‚ ici en usort pour cause d'homonymie avec la commande dos)

#entrée :
copier-coller de la liste des résonateurs de chaque portail concerné, depuis la fenêtre d'infos portails IITC vers un fichier texte
Exelmech	L 8 	L 8 	bicouben
Spawnor	L 8 	L 8 	537719
Mor14rty	L 8 	L 8 	Goodgenesis
Exelwoman	L 8 	L 8 	GNusy
gratouille81	L 8 	L 8 	DukeAstar
bibisse78	L 8 	L 8 	Exelmech
Rapharen	L 8 	L 8 	Neorafter
jamestof	L 8 	L 8 	Exelwoman

#sortie :
liste des pseudos avec le nombre de résonateurs posés par chacun
AKAJR 81
gratouille81 58
Exelwoman 57
Exelmech 57
lordnotech 51
537719 42
DukeAstar 36
vadarf 29
DocMamour 28
rocknlol 27
NCC1701R 26
vestySAV 24
expert75 24
Atomusk 24
GNusy 23
Finndow 21
rikshart 18
B0belix 18
Harmony2501 16
Kanchi 13
maclane4ever 12
Gnarfounet 12
cedric77 12
Morka 11

#Utilisation :
Donner en %1 le nom du fichier texte à traîter

:debut
gawk "{if ($1 ~ /./) poseur[$1]++;if ($NF !~ /^[1-8]$|\t/) poseur[$NF]++;} END {for (i in poseur) print i OFS poseur[i] OFS}" %1 |usort -n -k 2 -r
goto :eof
