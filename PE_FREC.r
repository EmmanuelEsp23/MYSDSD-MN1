#Prueba estadistica de frecuencias para numeros rectangulares
# ------------------------------------------------------------------------------
# PASO 1: CARGA DE DATOS
# ------------------------------------------------------------------------------

rm(list = ls())

cat("==========================================\n")
cat("   PRUEBA DE FRECUENCIAS (UNIFORME)   \n")
cat("==========================================\n\n")

# ------------------------------------------------------------------------------
# PASO 2: ENTRADAS DEL USUARIO
# ------------------------------------------------------------------------------

alpha_dato <- as.numeric(readline("Ingrese Alpha (%): "))
N <- as.integer(readline("Ingrese cantidad de números (N): "))

#Carga de la tabla de numeros uniformes (CSV)
if (!file.exists("Tablas/TablaUniformes.csv")) {
  stop("No se encuentra TablaUniformes.csv en carpeta Tablas")
}

datos <- read.csv("Tablas/TablaUniformes.csv")

# ------------------------------------------------------------------------------
# PASO 3: EXTRACCIÓN VERTICAL
# ------------------------------------------------------------------------------

numeros <- c()