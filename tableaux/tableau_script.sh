#!/usr/bin/bash
#==================================================================
#comportment du programme et comment on lance le programme - à écrire 

# Le programme contient 2 arguments:
#$1 = urls
#$2 = tableaux
#==================================================================
#pour lire des urls et recuperer les contenues
urls=$1 # le fichier d'URL en entrée
tableaux=$2 # le fichier HTML en sortie

#pour créer du HTML
echo "<html>" > $2 ;
echo "<head><title> Tableaux </title> </head>" >> $2 ;
echo "<body>" >> $2 ;

#pour créer des colonnes 
for fichier in $(ls $1)
do 
  echo " " >> $2 ; 
  echo "<table align=\"center\" border=\"10px\" bordercolor=\"red\">" >> $tableaux;
		compteur=1; # compteur d'URL
		echo "<tr><th colspan=\"11\">TABLEAU $compteur_tableau</th></tr>" >> $tableaux;
		echo "<tr>
		<td>ligne</td>
		<td>code</td>
        	<td>URL</td>
		<td>Encodage</td>
		</tr>" >> $tableaux;

#pour compter des tableaux
compteur_tableau=1 ;

#pour compter chaque ligne du tableau
compteur_ligne=1 ;

while read -r line;
do
	echo "ligne $compteur_ligne: $line";
	compteur_ligne=$((compteur_ligne+1));
done < $url_en.txt

while read -r URL; do
	echo -e "\tURL : $URL";
	code=$(curl -ILs $URL | grep -e "^HTTP/" | grep -Eo "[0-9]{3}" | tail -n 1)
	charset=$(curl -ILs $URL | grep -Eo "charset=(\w|-)+" | cut -d= -f2)
	echo -e "\tcode : $code";

	if [[ ! $charset ]]
	then
		echo -e "\tencodage non détecté.";
		charset="UTF-8";
	else
		echo -e "\tencodage : $charset";
	fi

	if [[ $code -eq 200 ]]
	then
		dump=$(lynx -dump -nolist -assume_charset=$charset -display_charset=$charset $URL)
		if [[ $charset -ne "UTF-8" && -n "$dump" ]]
		then
			dump=$(echo $dump | iconv -f $charset -t UTF-8//IGNORE)
		fi
	else
		echo -e "\tcode différent de 200 utilisation d'un dump vide"
		dump=""
		charset=""
	fi

	echo "$dump" > "dumps-text/$basename-$compteur_ligne.txt"

	echo "<tr><td>$lineno</td><td>$code</td><td><a href=\"$URL\">$URL</a></td><td>$charset</td></tr>" >> $2
	echo -e "\t--------------------------------"
	compteur_ligne=$((compteur_ligne+1));
done < $urls
echo "</table>" >> $tableaux
echo "</body></html>" >> $tableaux

#dumps_texts
for ligne in $(ls $1)
    do 
