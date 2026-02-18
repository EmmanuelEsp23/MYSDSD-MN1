#Generador congruencial multiplicativo

#Entradas
a <- as.numeric(readline(prompt = "Ingrese el valor de a: "))
m <- as.numeric(readline(prompt = "Ingrese el valor de m: "))
seed <- as.numeric(readline(prompt = "Ingrese la semilla inicial X0: "))

#Calcular el periodo esperado del generador (funciona como el modulo en el GCM)
pe <- m / 4
cat("Periodo esperado:", pe)

seeds <- numeric(pe) #Esta madre se puede hacer con un array, pero con la función numeric es mejor
#Definimos el periodo esperado como el tamaño tope porq así decía en la teoría
seeds[1] <- seed # Guardamos la semilla inicial en el primer lugar del vector
count <- 1
repetido <- FALSE

while (!repetido) {
    #Formula del generador congruencial multiplicativo
    xn <- (a * seeds[count]) %% m

    # Verificamos si ya existe en nuestro vector (no solo la semilla)
    # O si ya regresó a la semilla inicial
    if (xn == seed || count >= pe) {
        repetido <- TRUE
    } else {
        count <- count + 1
        seeds[count] <- xn
    }
}

# Limpiamos el vector de los ceros sobrantes
resultado <- seeds[1:count]
cat("\nCantidad de números generados:", length(resultado), "\n")

if (length(resultado) == pe) { #condicional de período de fiabilidad
    cat("El generador es de periodo completo\n")
} else {
    cat("El generador es de periodo incompleto\n")
}

#guardar los números rectangulares en un CSV
numeros <- resultado / m # Convertimos a números rectangulares
format <- format(round(numeros, 5), nsmall = 5) # Formateamos los números a 5 decimales
df <- data.frame(NumeroRectangular = format) # Creamos un dataframe para guardar los números
write.csv(df, file = paste0("datasetsGCMult/", readline(prompt = "\nNombre del archivo: "), ".csv"), row.names = FALSE) # Guardamos el dataframe en un CSV
cat("Archivo generado.\n")