#!/bin/bash

#
# USO SCRIPT
#
usoScript(){
        echo "Uso: $0 -d search_dir [-h] "
        exit
}

calcular(){
calculo=$(cat $tmpFile |awk 'BEGIN{min=2**63-1; max=0}\
                        {if($1<min){min=$1};if($1>max){max=$1};total+=$1;count+=1;}\
                         END {print  total ":"total/count":"min":"max}')
echo $calculo >> $OUTFILE
rm  $tmpFile
}

#
# PROMEDIO DE TIEMPO DE LA SIMULACION Y LA MEMORIA USADA
#       Salida: archivo metrics.txt con la siguiente estructura
#       	timestamp:promedio:min:max
#		memUsed:promedio:min:max
#
tiempoSimulacionTotal(){
	OUTFILE="metrics.txt"
	archivoUsoEjecucion=(`find $searchDir -name 'executionSummary-0*.txt'`) 

        tmpFile="fracaso.txt"
        > $tmpFile

        for i in ${archivoUsoEjecucion[*]};
        do
                printf "> %s\n" $i
                tiempos=(`cat $i |tail -n+2 |awk -F ':' 'BEGIN{sum=0}{sum=$6+$7+$8;}END{print sum}' >> $tmpFile`)
        done

printf "timestamp:promedio:min:max\n" >> $OUTFILE
calcular
#############################################################################################################################
        > $tmpFile
        for i in ${archivoUsoEjecucion[*]};
        do
                printf "> %s\n" $i
                tiempos=(`cat $i |tail -n+2 |awk -F ':' 'BEGIN{sum=0}{sum=$9;}END{print sum}' >> $tmpFile`)
        done

printf "memUsed:promedio:min:max\n" >> $OUTFILE
calcular
}

#
# PROMEDIO DE USO DE TELÉFONOS MÓVILES
#       Salida: archivo usePhone-stats.txt con la siguiente estructura
#        	timestamp:promedio:min:max
#
#
promedioTelefonosMoviles(){
OUTFILE="usePhone-stats.txt"
        archivoUsoEjecucion=(`find $searchDir -name '*usePhone-*.txt' -print | sort`)

        tmpFile="fracaso.txt"
        > $tmpFile

for i in ${archivoUsoEjecucion[*]};
        do
                printf "> %s\n" $i
                tiempos=(`cat $i | tail -n+3 | cut -d ':' -f 3`)
                for i in ${tiempos[*]};
                do
                        printf "%d:" $i >> $tmpFile
                done
                printf "\n" >> $tmpFile
        done

        #Determinar el total de columnas a procesar
                #Sacar la primera linea                 : head -1 $tmpFile
                #eliminar el último caracter    : sed 's/.$//'
                #cambiar todos los ':' por '\n' : tr ':' '\n'
                #contar las líneas                              : wc -l

        totalFields=$(head -1 $tmpFile | sed 's/.$//' | tr ':' '\n'| wc -l)

        > $OUTFILE

        printf "timestamp:promedio:min:max\n" >> $OUTFILE
        for i in $(seq 1 $totalFields); do
                out=$(cat $tmpFile | cut -d ':' -f $i |\
                        awk 'BEGIN{ min=2**63-1; max=0}\
                                {if($1<min){min=$1};if($1>max){max=$1};total+=$1; count+=1;}\
                                END {print total/count":"max":"min}')
                printf "$i:$out\n" >> $OUTFILE
        done

        rm $tmpFile
}

#
# PROMEDIO DE TIEMPO DE EVACUACION SEGUN DISTINTOS TIPOS DE GRUPOS DE PERSONAS
#       Salida: archivo evacuation.txt con la siguiente estructura
#                       alls:promedio:min:max
#			residents:proemdio:min:max
#			visitorsI:promedio:min:max
#			residents-G0:promedio:min:max
#			residents-G1:promedio:min:max
#			residents-G2:promedio:min:max
#			residents-G3:promedio:min:max
#			visitorsI-G0:promedio:min:max
#			visitorsI-G1:promedio:min:max
#			visitorsI-G2:promedio:min:max
#			visitorsI-G3:promedio:min:max

tiempoEvacuacionPersonas(){
OUTFILE="evacuation.txt"
        archivoUsoEjecucion=(`find $searchDir -name 'summary-0*.txt'`)

        tmpFile="fracaso.txt"       
        > $tmpFile

        for i in ${archivoUsoEjecucion[*]};
        do
                printf "> %s\n" $i
                tiempos=(`cat $i |tail -n+2 |awk -F ':' '{sum=0;sum+=$8;print sum};' >> $tmpFile`)
        done

printf "alls:promedio:min:max\n" >> $OUTFILE
calcular
#############################################################################################################################
        > $tmpFile
        for i in ${archivoUsoEjecucion[*]};
        do
                printf "> %s\n" $i
                tiempos=(`cat $i |tail -n+2 |awk -F ':' '{if($3 == 0) {sum=0;sum+=$8;print sum}};' >> $tmpFile`)
        done

printf "residents:promedio:min:max\n" >> $OUTFILE
calcular
#############################################################################################################################
        > $tmpFile
        for i in ${archivoUsoEjecucion[*]};
        do
                printf "> %s\n" $i
                tiempos=(`cat $i |tail -n+2 |awk -F ':' '{if($3 == 1) {sum=0;sum+=$8;print sum}};' >> $tmpFile`)
        done

printf "visitorsI:promedio:min:max\n" >> $OUTFILE
calcular
#############################################################################################################################
        > $tmpFile
        for i in ${archivoUsoEjecucion[*]};
        do
                printf "> %s\n" $i
                tiempos=(`cat $i |tail -n+2 |awk -F ':' '{if($3 == 0 && $4 == 0) {sum=0;sum+=$8;print sum}};' >> $tmpFile`)
        done

printf "residents-G0:promedio:min:max\n" >> $OUTFILE
calcular
#############################################################################################################################
        > $tmpFile
        for i in ${archivoUsoEjecucion[*]};
        do
                printf "> %s\n" $i
                tiempos=(`cat $i |tail -n+2 |awk -F ':' '{if($3 == 0 && $4 == 1) {sum=0;sum+=$8;print sum}};' >> $tmpFile`)
        done

printf "residents-G1:promedio:min:max\n" >> $OUTFILE
calcular
#############################################################################################################################
        > $tmpFile
        for i in ${archivoUsoEjecucion[*]};
        do
                printf "> %s\n" $i
                tiempos=(`cat $i |tail -n+2 |awk -F ':' '{if($3 == 0 && $4 == 2) {sum=0;sum+=$8;print sum}};' >> $tmpFile`)
        done

printf "residents-G2:promedio:min:max\n" >> $OUTFILE
calcular
#############################################################################################################################
        > $tmpFile
        for i in ${archivoUsoEjecucion[*]};
        do
                printf "> %s\n" $i
                tiempos=(`cat $i |tail -n+2 |awk -F ':' '{if($3 == 0 && $4 == 3) {sum=0;sum+=$8;print sum}};' >> $tmpFile`)
        done

printf "residents-G3:promedio:min:max\n" >> $OUTFILE
calcular
#############################################################################################################################
        > $tmpFile
        for i in ${archivoUsoEjecucion[*]};
        do
                printf "> %s\n" $i
                tiempos=(`cat $i |tail -n+2 |awk -F ':' '{if($3 == 1 && $4 == 0) {sum=0;sum+=$8;print sum}};' >> $tmpFile`)
        done

printf "visitorsI-G0:promedio:min:max\n" >> $OUTFILE
calcular
#############################################################################################################################
        > $tmpFile
        for i in ${archivoUsoEjecucion[*]};
        do
                printf "> %s\n" $i
                tiempos=(`cat $i |tail -n+2 |awk -F ':' '{if($3 == 1 && $4 == 1) {sum=0;sum+=$8;print sum}};' >> $tmpFile`)
        done

printf "visitorsI-G1:promedio:min:max\n" >> $OUTFILE
calcular
#############################################################################################################################
        > $tmpFile
        for i in ${archivoUsoEjecucion[*]};
        do
                printf "> %s\n" $i
                tiempos=(`cat $i |tail -n+2 |awk -F ':' '{if($3 == 1 && $4 == 2) {sum=0;sum+=$8;print sum}};' >> $tmpFile`)
        done


printf "visitorsI-G2:promedio:min:max\n" >> $OUTFILE
calcular
#############################################################################################################################
        > $tmpFile
        for i in ${archivoUsoEjecucion[*]};
        do
                printf "> %s\n" $i
                tiempos=(`cat $i |tail -n+2 |awk -F ':' '{if($3 == 1 && $4 == 3) {sum=0;sum+=$8;print sum}};' >> $tmpFile`)
        done


printf "visitorsI-G3:promedio:min:max\n" >> $OUTFILE
calcular
}


#
# MAIN
#
while getopts "d:h" opt; do
  case ${opt} in
    d )
                searchDir=$OPTARG
      ;;
    h )
                usoScript
      ;;
    \? )
                usoScript
      ;;
  esac
done
shift $((OPTIND -1))

if [ -z $searchDir ]; then
        usoScript
fi

if [ ! -d $searchDir ]; then
        echo "$searchDir no es un directorio"
        exit
fi

printf "Directorio busqueda: %s\n" $searchDir


#Conjunto de funciones que se ejecutan para mostrar los resultados de cada problema requerido
promedioTelefonosMoviles
tiempoEvacuacionPersonas
tiempoSimulacionTotal
