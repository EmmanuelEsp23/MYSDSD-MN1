# ==============================================================================
# PRUEBA DE PROMEDIOS - NÚMEROS RECTANGULARES
# ==============================================================================

rm(list = ls())

cat("==========================================\n")
cat("   PRUEBA DE PROMEDIO (UNIFORME)   \n")
cat("==========================================\n\n")

# ------------------------------------------------------------------------------
# PASO 1: CARGAR TABLA
# ------------------------------------------------------------------------------

if (!file.exists("Tablas/TablaUniformes.csv")) {
  stop("No se encuentra TablaUniformes.csv en carpeta Tablas")
}

datos <- read.csv("Tablas/TablaUniformes.csv")

# ------------------------------------------------------------------------------
# PASO 2: ENTRADAS DEL USUARIO
# ------------------------------------------------------------------------------

alpha_dato <- as.numeric(readline("Ingrese Alpha (%): "))
N <- as.integer(readline("Ingrese cantidad de números (N): "))
renglon_inicio <- as.integer(readline("Ingrese Renglón inicial (1-8): "))
columna_nombre <- toupper(readline("Ingrese Columna (C1-C10): "))

if (!(columna_nombre %in% colnames(datos))) {
  stop("Columna no válida.")
}

# ------------------------------------------------------------------------------
# PASO 3: EXTRACCIÓN VERTICAL
# ------------------------------------------------------------------------------

numeros <- c()
subset_tabla <- datos[datos$Renglon >= renglon_inicio, ]

for (i in 1:nrow(subset_tabla)) {
  
  if (length(numeros) == N) break
  
  valor <- subset_tabla[i, columna_nombre]
  numeros <- c(numeros, valor)
}

if (length(numeros) < N) {
  stop("No hay suficientes datos hacia abajo. Seleccione otro renglón.")
}

cat("\nNúmeros seleccionados:\n")
print(numeros)

# ------------------------------------------------------------------------------
# PASO 4: CÁLCULO DEL ESTADÍSTICO
# ------------------------------------------------------------------------------

promedio <- mean(numeros)

numerador <- (promedio - 0.5) * sqrt(N)
denominador <- sqrt(1/12)

Z0 <- abs(numerador / denominador)

# ------------------------------------------------------------------------------
# PASO 5: Z DE TABLAS
# ------------------------------------------------------------------------------

alpha <- alpha_dato / 100
Z_tabla <- qnorm(1 - alpha/2)

# ------------------------------------------------------------------------------
# PASO 6: RESULTADOS FINALES
# ------------------------------------------------------------------------------

cat("\n==========================================\n")
cat("              RESULTADOS                  \n")
cat("==========================================\n")

cat(sprintf("Promedio (x̄): %.6f\n", promedio))
cat(sprintf("Z0 calculado: %.4f\n", Z0))
cat(sprintf("Z tabla (Zα/2): %.4f\n", Z_tabla))

cat("\nComparación:\n")
cat(sprintf("¿ %.4f < %.4f ?\n", Z0, Z_tabla))

cat("\n------------------------------------------\n")

if (Z0 < Z_tabla) {
  cat("Por lo tanto los números son ACEPTADOS.\n")
} else {
  cat("Por lo tanto los números son NO ACEPTADOS.\n")
}

cat("==========================================\n")