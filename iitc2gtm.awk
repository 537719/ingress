# iitc2gtm.awk
# 23:14 16/05/2014
# transforme un tableau HTML tel qu'affiché par le plugin "portal list" d'iitc en un fichier de waypoints gpstm
# procède à partir du monoligne sed suivant :
# ssed "s/.*\pll=\([0-9]*\.[0-9]*\),\([0-9]*\.[0-9]*\). title=.*\d62\(.*\)\d60\/a.*/\1;\2;\3/"
#
# 07:09 18/05/2014 version définitive : produit niveau et faction dans le wpt name, nom du portail dans les comments, accents conservés
# MODIF 00:05 06/06/2014 : format des wpts "symbol with comments" au lieu de "symbol with name"
BEGIN {
	OFS=","
# écriture de l'en-tête gpstm
	print "Version,212"
	print ""
	print "WGS 1984 (GPS),217, 6378137, 298.257223563, 0, 0, 0"
	print "USER GRID,0,0,0,0,0"
}
# MAIN
{
	# sortie=gensub(/.*\pll=([0-9]*\.[0-9]*),([0-9]*\.[0-9]*). title=.*\d62(.*)\d60\/a.*/,"\\1 \\2 \\3","g",$0)
	sortie=gensub(/.*pll=([0-9]*\.[0-9]*),([0-9]*\.[0-9]*). title=.*>(.*)<\/a.*/,NR "v1rgul3" "\\1v1rgul3\\2v1rgul3\\3","g",$0)
	sortir=NR "v1rgul3"
	res=""
	enl=""
	neutral=""
	prefixe=""
	icone=143
	if (sortie ~ sortir) {
		# prefixe=gensub(/.*(enl|res|neutral).><td>([0-9]).*/,"e","g",$0)
		enl=gensub(/.*enl.><td>([0-9]).*/,"e","g",$0)
		res=gensub(/.*res.><td>([0-9]).*/,"r","g",$0)
		neutral=gensub(/.*neutral.><td>([0-9]).*/,"n","g",$0)
		if (length(enl)==1) {
			prefixe= enl
			icone=222
		}
		if (length(res)==1) {
			prefixe= res
			icone=221
		}
		if (length(neutral)==1) {
			prefixe= neutral
			icone=223
		}
		lev=gensub(/.*class=.L([0-8]).*/,"\\1","g",$0)
	gsub(/\,/,"-",sortie)
	gsub(/v1rgul3/,",",sortie)
		sortie="w" OFS "d" OFS lev prefixe sortie OFS "00/00/00,00:00:00,0,2" OFS icone OFS "0,13"
		print sortie
	}
}
