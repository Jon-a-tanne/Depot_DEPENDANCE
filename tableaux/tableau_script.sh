#!/usr/bin/bash
#==================================================================
#comportment du programme et comment on lance le programme - à écrire 

# Le programme contient 3 arguments:
#$1 = urls
#$2 = tableaux
#$3 = motif
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

#pour compter des tableaux
compteur_tableau=1 ;

#pour compter chaque ligne du tableau
compteur_ligne=1 ;

while read -r line;
do
	echo "ligne $compteur_ligne: $line";
	compteur_ligne=$((compteur_ligne+1));
done < $urls

#lire chaque url du fichier
