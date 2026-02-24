# script para verificar formato de números aleatorios

# 1. Cargar los datos
# Asegúrate de que el archivo esté en la misma carpeta que este script
if (!file.exists("Tablas/TablaUniformes.csv")) {
  stop("¡Error! No se encontró el archivo 'TablaUniformes.csv'.")
}

datos <- read.csv("Tablas/TablaUniformes.csv")

# 2. Solicitar Input al usuario
cat("--- Selector de Números Aleatorios ---\n")

# Leer Renglón
cat("Ingrese el número de Renglón (1 al 8): ")
renglon_ingresado <- as.integer(readLines(n = 1))

# Leer Columna
cat("Ingrese la Columna (ejemplo: C1, C2... C10): ")
columna_ingresada <- toupper(readLines(n = 1)) # Lo convierte a mayúsculas por si acaso

# 3. Validación y Extracción
if (renglon_ingresado %in% unique(datos$Renglon) && columna_ingresada %in% colnames(datos)) {
  
  # Filtramos los datos por el renglón y seleccionamos la columna deseada
  numeros_seleccionados <- datos[datos$Renglon == renglon_ingresado, columna_ingresada]
  
  cat("\nExito. Los números encontrados son:\n")
  print(numeros_seleccionados)
  
  # Verificación de formato
  cat("\nVerificación de clase:", class(numeros_seleccionados))
  cat("\nCantidad de elementos:", length(numeros_seleccionados), "\n")
  
} else {
  cat("\n[!] Error: Renglón o Columna no válidos. Intenta de nuevo.\n")
}