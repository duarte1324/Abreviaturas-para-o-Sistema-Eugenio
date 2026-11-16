#!/bin/bash

#Leio o ficheiro palavras_treino.txt linha por linha
#Para cada palavra faço as seguintes operações:
#	Removo as vogais
#	Verifico se aquela abreviatura já existe
#	Se não existe, guardo em abreviaturas_contracao.txt da seguinte forma
#		abreviatura : brvtr

vogais='aeiouáàâãéèêẽíìîĩóòôõúùûũAEIOUÁÀÂÃÉÈÊẼÍÌÎĨÓÒÔÕÚÙÛŨ'

> "abreviaturas_contracao.txt"

echo "Lendo palavras_treino.txt..."
while read palavra; do
	abreviatura=$(echo "$palavra" | sed "s/[$vogais]//g")
	n_repeticoes=$(grep "$abreviatura" "abreviaturas_contracao.txt" | wc -l)
	if [ $n_repeticoes -eq 0 ]; then
		echo "$palavra : $abreviatura" >> "abreviaturas_contracao.txt"
	else
		echo "$palavra repetida! Ignorando..."
	fi
done < "../palavras_treino.txt"
