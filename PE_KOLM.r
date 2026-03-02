# ==============================================================================
# PRUEBA DE KOLMOGOROV-SMIRNOV - NÚMEROS RECTANGULARES
# ==============================================================================

rm(list = ls())

cat("==========================================\n")
cat("   PRUEBA DE KOLMOGOROV-SMIRNOV      \n")
cat("==========================================\n\n")

# ------------------------------------------------------------------------------
# PASO 1: CARGAR TABLA
# ------------------------------------------------------------------------------

if (!file.exists("Tablas/TablaUniformes.csv")) {
  stop("Error: No se encuentra TablaUniformes.csv en carpeta Tablas.")
}

datos <- read.csv("Tablas/TablaUniformes.csv")

# ------------------------------------------------------------------------------
# PASO 2: ENTRADAS DEL USUARIO
# ------------------------------------------------------------------------------

alpha_dato <- as.numeric(readline("Ingrese Alpha (%): "))
N <- as.integer(readline("Ingrese cantidad de números (N): "))
renglon_inicio <- as.integer(readline("Ingrese Renglón inicial: "))
columna_nombre <- toupper(readline("Ingrese Columna (C1-C10): "))

numeros <- c()
subset_tabla <- datos[datos$Renglon >= renglon_inicio, ]

for (i in 1:nrow(subset_tabla)) {
  if (length(numeros) == N) break
  numeros <- c(numeros, subset_tabla[i, columna_nombre])
}

if (length(numeros) < N) {
  stop("Error: No hay suficientes datos para el tamaño de muestra solicitado.")
}

# ------------------------------------------------------------------------------
# PASO 3: ORDENAR EN FORMA ASCENDENTE
# ------------------------------------------------------------------------------
numeros_ord <- sort(numeros)

# ------------------------------------------------------------------------------
# PASO 4 Y 5: CALCULAR DISTANCIA ACUMULADA Y ESTADÍSTICO Dn
# ------------------------------------------------------------------------------
# i representa la posición del número ordenado
i <- 1:N
F_xi <- i / N  # Paso 4: F(xi) = i/N

# Paso 5: Dn = max | F(xi) - xi |
diferencias_absolutas <- abs(F_xi - numeros_ord)
Dn_calculado <- max(diferencias_absolutas)

# ------------------------------------------------------------------------------
# PASO 6: ESTADÍSTICO DE TABLAS (d_alpha,N)
# ------------------------------------------------------------------------------
# Proporcionamos el valor crítico basado en el alpha ingresado (para N > 35)
alpha <- alpha_dato / 100

if (N <= 35) {
  cat("\n[!] Nota: Se recomienda ingresar d_alpha_N manualmente desde tabla física para N <= 35.\n")
  d_tabla <- as.numeric(readline("Ingrese el valor de tabla (d_alpha,N): "))
} else {
  # Aproximación asintótica estándar
  if (alpha == 0.05) d_tabla <- 1.36 / sqrt(N)
  else if (alpha == 0.01) d_tabla <- 1.63 / sqrt(N)
  else if (alpha == 0.10) d_tabla <- 1.22 / sqrt(N)
  else d_tabla <- sqrt(-0.5 * log(alpha/2)) / sqrt(N)
}

# ------------------------------------------------------------------------------
# PASO 7: COMPARACIÓN Y RESULTADO
# ------------------------------------------------------------------------------
cat("\n==========================================\n")
cat("              RESULTADOS K-S              \n")
cat("==========================================\n")

# Mostramos tabla de los primeros 10 cálculos para verificación visual
df_resultados <- data.frame(
  i = i,
  xi = numeros_ord,
  F_xi = F_xi,
  Abs_Diff = diferencias_absolutas
)

cat("Muestra de los cálculos (Primeros 10):\n")
print(head(df_resultados, 10))

cat("\n------------------------------------------\n")
cat(sprintf("Estadístico Dn calculado: %.4f\n", Dn_calculado))
cat(sprintf("Estadístico d_tabla:      %.4f\n", d_tabla))
cat("\nComparación:\n")
cat(sprintf("¿ %.4f < %.4f ?\n", Dn_calculado, d_tabla))
cat("------------------------------------------\n")

if (Dn_calculado < d_tabla) {
  cat("Resultado: NÚMEROS ACEPTADOS.\n")
} else {
  cat("Resultado: NÚMEROS NO ACEPTADOS.\n")
}
cat("==========================================\n")