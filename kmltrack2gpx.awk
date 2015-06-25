# kmltrack2gpx.awk
# 21:59 01/01/2014
# convertit un fichier track tel que issu de l'historique google maps
# https://maps.google.com/locationhistory/b/0/
# en un fichier gpx conservant l'horodatage
# usage :
# gawk -f kmltrack2gpx.awk [infile] >[outfile.gpx]


BEGIN {
OFS="\042"
tabu="\011"
print "<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>"
print "<gpx version='1.1' creator='GPS Essentials - http://www.gpsessentials.com' xmlns='http://www.topografix.com/GPX/1/1'>"

}
{	#MAIN
	if (/Placemark/) {
		$0=gensub(/Placemark/,"trk","g",$0)
		print tabu tabu $0
	}
	if (/description/) {
		$0=gensub(/description/,"desc","g",$0)
		print tabu tabu $0
	}
	if (/name/) {
		print tabu tabu $0
	}
	if (/styleUrl/) {
		$0=gensub(/styleUrl/,"number","g",$0)
		print tabu tabu $0
	}
	if (/gx:Track/) {
		$0=gensub(/gx:Track/,"trkseg","g",$0)
		print tabu tabu $0
	}

	if ($0 ~ /when/) {
	# <when>2013-12-31T16:20:52.253-08:00</when>
	# <time>2013-03-16T12:34:50Z</time>
		heuredate=gensub(/.\/*when./,"","g",$0)
		# heuredate=gensub(/\.[0-9]*-[0-2][0-9]\:[0-9][0-9]/,"Z",1,heuredate)
		heuredate="<time>" heuredate "</time>"
		muet=0
	}
	if ($0 ~ /gx\:coord/) {
	# <gx:coord>2.2315934 48.8474809 0</gx:coord>
	# <trkpt lat="45.470676" lon="6.907986">
		split(gensub(/.\/*gx\:coord./,"","g",$0),coord)
		lon=coord[1]
		lat=coord[2]
		ele=coord[3]
		print tabu tabu tabu "<trkpt lat=" OFS lat OFS " lon=" OFS lon OFS ">"
		print tabu tabu tabu tabu "<ele>" ele "</ele>"
		print tabu tabu tabu tabu heuredate
		print tabu tabu tabu "</trkpt>"
	}
}
END {
print "</gpx>"
}
