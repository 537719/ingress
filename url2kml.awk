# url2kml.awk
# G. Métais 16:41 25/06/2015
# convertit les url intel map de liens entre portails vers un fichier kml
#
# usage :
# gawk -f url2kml.awk [infile or paste url to console] >[outfile.kml]
BEGIN {
	print "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
	print "<kml xmlns=\"http://earth.google.com/kml/2.0\">"
	print "\t<Document>"
	print "\t\t<Placemark>"
}
{ #MAIN
	sub(/http.*pls/,"")
	sortie=gensub(/[_|=]([0-9]+\.[0-9]+),([0-9]+\.[0-9]+),([0-9]+\.[0-9]+),([0-9]+\.[0-9]+)/,"\t\t\t<LineString><coordinates>\\2,\\1,0 \\4,\\3,0 </coordinates></LineString>\n","g")
	print sortie
}
END {
	print "\t\t</Placemark>"
	print "\t</Document>"
	print "</kml>"
}

