# Generador de números rectangulares aleatorios que pidió el este wey Evanivaldo
n <- as.integer(readline(prompt = "¿Cuántos números deseas generar? "))
#Esta madre representa la pauta de cuántos números aleatorios se van a generar

numeros <- runif(n, min = 0, max = 1) #esta madre decide el rango que pidió
format <- format(round(numeros, 5), nsmall = 5) #el formato que quiere este wey

# Crear un dataframe para guardar las chingaderas en un pinche CSV y que se vea bonito
df <- data.frame(NumeroRectangular = format)

#Aquí se guardará el CSV dentro de la carpeta datasets dentro del directorio
#Según el VSC pone en azul la línea de abajo es pura mmda no son errores nomas es porque tiro la weba y no paso espacios
write.csv(df, file = paste0("datasetsRNG/", readline(prompt = "Nombre del archivo: "), ".csv"), row.names = FALSE)
cat("Archivo generado.\n")
