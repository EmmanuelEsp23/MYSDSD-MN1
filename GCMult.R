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
