# ==============================================================================
# PRUEBA DE KOLMOGOROV-SMIRNOV - NUMEROS RECTANGULARES
# ==============================================================================

rm(list = ls())

cat("==========================================\n")
cat("   PRUEBA DE KOLMOGOROV-SMIRNOV (K-S)     \n")
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

# ------------------------------------------------------------------------------
# PASO 3: EXTRACCIÓN DE DATOS
# ------------------------------------------------------------------------------

numeros <- c()
subset_tabla <- datos[datos$Renglon >= renglon_inicio, ]

for (i in 1:nrow(subset_tabla)) {
  if (length(numeros) == N) break
  numeros <- c(numeros, subset_tabla[i, columna_nombre])
}

if (length(numeros) < N) {
  stop("Error: No hay suficientes datos hacia abajo. Seleccione otro renglón.")
}

cat("\nNúmeros seleccionados:\n")
print(numeros)

# ------------------------------------------------------------------------------
# PASO 4: EJECUCIÓN DE LA PRUEBA DE KOLMOGOROV-SMIRNOV
# ------------------------------------------------------------------------------

# Comparamos la muestra contra la distribución Uniforme teórica U(0,1)
ks_resultado <- ks.test(numeros, "punif", 0, 1)
cat("Estadístico Dn calculado: ", ks_resultado$statistic, "\n")

Dn_calculado <- as.numeric(ks_resultado$statistic)
p_valor <- ks_resultado$p.value
alpha <- alpha_dato / 100

# ------------------------------------------------------------------------------
# PASO 5: RESULTADOS Y CRITERIO DE DECISIÓN
# ------------------------------------------------------------------------------
cat("\n==========================================\n")
cat("              RESULTADOS K-S              \n")
cat("==========================================\n")

cat(sprintf("Estadístico Dn calculado: %.6f\n", Dn_calculado))
cat(sprintf("Valor p (p-value):       %.6f\n", p_valor))
cat(sprintf("Alpha de referencia:     %.4f\n", alpha))

cat("\nCriterio de Decisión:\n")
cat(sprintf("¿ p-valor (%.5f) > Dn calculado (%.5f) ?\n", p_valor, Dn_calculado))
cat("------------------------------------------\n")

# En estadística profesional, si p-valor > alpha, NO se rechaza la uniformidad
if (p_valor >  Dn_calculado) {
  cat("Por lo tanto, los números son aceptados.\n")
} else {
  cat("Por lo tanto, los números no son aceptados.\n")
}
cat("==========================================\n")