# TSS00-Taller1
autor: Ignacio Miranda

Correo Institucional: ignacio.miranda@alumnos.uv.cl

El diseño de la solucion consiste en 3 funciones, por cada problema cada funcion abre el conjunto de archivos designados por su problema y estos quedan en una variable para luego ser recorrida y obtener las columnas necesarias para la solucion, este conjunto de datos se escribiran a modo de una columna en un archivo temporal para facilitar los calculos para obtener los resultados requeridos, despues de realizar todos estos calculos estos quedan en una variable y esta variable escribe todos los datos en el archivo señalado por cada problema

Funciones

tiempoSimulacionTotal(): calcula el tiempo del promedio de la simulacion y su memoria usada, el conjunto de archivos que ocupa es executionSummary y el archivo en el cual muestra los datos es llamado metrics.txt

promedioTelefonosMoviles(): calcula el tiempo promedio del uso de los telefonos moviles, el conjunto de archivos que ocupa es usePhone y el archivo en el cual muestra los datos es llamado usePhone-stats.txt

tiempoEvacuacionPersonas(): calcula el tiempo promedio de la evacuacion de personas segun el conjunto completo y diferenciado por residentes o visitantes, el conjunto de archivos que ocupa es summary y el archivo en el cual muestra los datos es llamado evacuation.txt

calcular(): funcion que obtiene los datos del archivo temporal llamado tmpFile y los calcula para obtener los resultados que se esperan para cada problema

Conjunto de variables dentro de cada funcion

OUTFILE: variable en la cual se escribiran los datos que pide cada problema

archivoUsoEjecucion: variable en la cual se abren todos los archivos que tiene los datos necesarios para la solucion del problema

tmpFile: archivo temporal donde se dejan los datos especificos para calcular la solucion del problema estos datos se tomaron de los archivos de la variable archivoUsoEjecucion 

calculo: variable que se ocupa de calcular los datos del archivo tmpFile estos seran el total, promedio, minimo y maximo
  
