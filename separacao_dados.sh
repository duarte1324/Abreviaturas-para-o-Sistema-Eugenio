#!/bin/bash

# Para a leitura de dados, os dados devem estar num ficheiro com o nome words.txt

#verificar a existência do ficheiro palavras.txt

#Se não existe, parar script
#Se existe continuar

#Percurrer as plavras
#Contar para cada palavra o numero de vezes que aparece
#Guardar num ficheiro frequencias.txt
 
#No fim organizar ordenadamente, os de maior frequencia em primeiro lugar
#Depois ler esse e separar:
##	n_treino = int(n_palavras * 0.8)
# Separar os dados (n_treino para texto_treino.txt e n_estudo para texto_estudo.txt)

if [ ! -f $"palavras.txt" ]; then
	echo "Erro: o ficheiro não existe!"
	exit 1
fi

echo "A processar ficheiro..."

> "frequencia.txt"
> "temporario.txt"


while read linha; do
	for palavra in $linha; do
		while read palavra1; do
			if [ $palavra1 = $palavra ]; then
				continue 2
			fi
		done < temporario.txt
		contador=$(grep -oi "$palavra" words.txt | wc -l)
		echo "$palavra" >> temporario.txt
		echo "$palavra	$contador" >> frequencia.txt
	done
done < palavras.txt

sort -k2 -r -n frequencia.txt > temporario.txt
mv temporario.txt frequencia.txt

echo "Ficheiro Processado Corretamente!"

echo "A separar os dados..."

n_palavras=$(wc -l frequencia.txt | awk '{print $1}')

n_treino=$((n_palavras*80/100))
n_estudo=$((n_palavras - n_treino))

echo "Numero de palavras: $n_palavras"
echo "Numero para treino: $n_treino"
echo "Numero para estudo: $n_estudo"

contador=0

> "palavras_treino.txt"
> "palavras_estudo.txt"

while read linha; do
	((contador++))
	palavra=$(echo "$linha" | cut -f1)
	if [ $contador -le $n_treino ]; then
		echo "$palavra" >> palavras_treino.txt
	else
		echo "$palavra" >> palavras_estudo.txt
	fi
done < frequencia.txt
	


