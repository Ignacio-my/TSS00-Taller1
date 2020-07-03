# TSS00-Taller1
autor: Ignacio Miranda

Correo Institucional: ignacio.miranda@alumnos.uv.cl

El diseño de la solucion consiste en 3 funciones

tiempoSimulacionTotal(): calcula el tiempo del promedio de la simulacion y su memoria usada, el conjunto de archivos que ocupa es executionSummary y el archivo en el cual muestra los datos es llamado metrics.txt

promedioTelefonosMoviles(): calcula el tiempo promedio del uso de los telefonos moviles, el conjunto de archivos que ocupa es usePhone y el archivo en el cual muestra los datos es llamado usePhone-stats.txt

tiempoEvacuacionPersonas(): calcula el tiempo promedio de la evacuacion de personas segun el conjunto completo y diferenciado por residentes o visitantes, el conjunto de archivos que ocupa es summary y el archivo en el cual muestra los datos es llamado evacuation.txt

Conjunto de variables dentro de cada funcion
OUTFILE: variable en la cual se escribiran los datos que pide cada problema


Por cada problema cada funcion abre el conjunto de archivos designados por su problema y estos quedan en una variable para luego ser recorrida y obtener las columnas necesarias para la solucion, este conjunto de datos se escribiran a modo de una columna en un archivo temporal para facilitar los calculos para obtener los resultados requeridos, despues de realizar todos estos calculos estos quedan en una variable y esta variable escribe todos los datos en el archivo señalado por cada problema  
