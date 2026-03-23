# Entradas
a <- as.numeric(readline(prompt = "Ingrese el valor de a: "))
c <- as.numeric(readline(prompt = "Ingrese el valor de c: "))
m <- as.numeric(readline(prompt = "Ingrese el valor de m: "))
seed <- as.numeric(readline(prompt = "Ingrese la semilla inicial X0: "))

# Preasignación de memoria para la secuencia
seeds <- numeric(m)
seeds[1] <- seed

# Registro lógico O(1) para detectar cualquier repetición al instante
# Tamaño m, ya que los números generados van de 0 a m-1
vistos <- logical(m)
vistos[seed + 1] <- TRUE # +1 porque R indexa desde 1, pero los residuos incluyen el 0

count <- 1 
repetido <- FALSE 

while (!repetido && count < m) {
  # Fórmula del generador congruencial mixto
  xn <- (a * seeds[count] + c) %% m
  
  # Verificamos si el número ya salió previamente (sea o no la semilla)
  if (vistos[xn + 1]) {
    repetido <- TRUE
  } else {
    count <- count + 1
    seeds[count] <- xn
    vistos[xn + 1] <- TRUE # Marcamos el número como visto
  }
}

# Limpiamos el vector de los espacios no utilizados
resultado <- seeds[1:count]
cat("\nCantidad de números únicos generados:", length(resultado), "\n")

# Condicional de periodo
if (length(resultado) == m) {
  cat("El generador es de periodo completo (alcanzó m iteraciones sin repetir).\n")
} else {
  cat("El generador es de periodo incompleto.\n")
}

# Transformación a números rectangulares
# Usamos round() para mantener la naturaleza numérica de los datos
numeros_rectangulares <- round(resultado / m, 5) 
df <- data.frame(NumeroRectangular = numeros_rectangulares)

# Manejo seguro de archivos y directorios
nombre_archivo <- readline(prompt = "\nIngrese el nombre del archivo a guardar (sin extensión): ")
directorio <- "datasetsGCM"

if (!dir.exists(directorio)) {
  dir.create(directorio) # Crea la carpeta si no existe, evitando el error de I/O
  cat("Directorio '", directorio, "' creado.\n", sep="")
}

ruta_completa <- paste0(directorio, "/", nombre_archivo, ".csv")
write.csv(df, file = ruta_completa, row.names = FALSE)

cat("Archivo guardado exitosamente en:", ruta_completa, "\n")