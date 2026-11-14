#!/bin/bash

# Para a leitura de dados, os dados devem estar num ficheiro com o nome words.txt

#verificar a existência do ficheiro words.txt

#Se não existe, parar script
#Se existe continuar

#Percurrer as plavras
#Contar para cada palavra o numero de vezes que aparece
#Guardar num ficheiro frequencias.txt
 
#No fim organizar ordenadamente, os de maior frequencia em primeiro lugar
#Depois ler esse e separar:
##	n_treino = int(n_palavras * 0.8)
# Separar os dados (n_treino para texto_treino.txt e n_estudo para texto_estudo.txt)

if [ ! -f $"words.txt" ]; then
	echo "Erro: o ficheiro não existe!"
	exit 1
fi

echo "A processar ficheiro..."

> "frequencia.txt"

while read linha; do
	for palavra in $linha; do
		contador=$(grep -oi "$palavra" words.txt | wc -l)
		echo "$palavra	$contador" >> frequencia.txt
	done
done < words.txt

sort -k2 -r -n frequencia.txt > temporario.txt
mv temporario.txt frequencia.txt
