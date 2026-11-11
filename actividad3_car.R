# ============================================================
# ACTIVIDAD 3: CLASIFICACIÓN DE AUTOMÓVILES CON R
# Estudiante: [Escriba nombres y apellidos]
# Asignatura: [Escriba la asignatura]
# Docente:    [Escriba el nombre del docente]
# Fecha:      [Escriba la fecha]
#
# Objetivo: comparar árbol de decisión, SVM radial y Random
# Forest para clasificar la evaluación de automóviles (CAR).
# El script genera resultados; no incluya cifras hasta ejecutarlo.
# ============================================================

# 1. PAQUETES --------------------------------------------------
paquetes <- c("caret", "rpart", "rpart.plot", "randomForest", "kernlab")
pendientes <- paquetes[
  !vapply(paquetes, requireNamespace, logical(1), quietly = TRUE)
]
if (length(pendientes) > 0) install.packages(pendientes)
invisible(lapply(paquetes, library, character.only = TRUE))

# 2. CARGA DEL CSV ---------------------------------------------
# Seleccione el archivo car.data / CSV descargado desde los recursos
# del curso o UCI. El archivo estándar de UCI no tiene encabezados.
archivo <- file.choose()
datos <- read.csv(
  archivo,
  header = FALSE,
  stringsAsFactors = FALSE,
  na.strings = c("", "?")
)

if (ncol(datos) != 7) {
  stop("Se esperaban 7 columnas: 6 atributos y la clase.")
}

# Descartar encabezado si el CSV sí lo contiene.
primera_fila <- tolower(trimws(as.character(unlist(datos[1, ]))))
if (any(primera_fila %in% c("buying", "precio_de_compra"))) {
  datos <- datos[-1, , drop = FALSE]
}

names(datos) <- c(
  "precio_de_compra", "maint_cost", "puertas", "person_capacity",
  "lug_boot", "seguridad", "clase"
)

# Normalizar texto y quitar espacios accidentales.
datos[] <- lapply(datos, function(x) tolower(trimws(as.character(x))))

# 3. EXPLORACIÓN Y LIMPIEZA ------------------------------------
cat("\n--- Primeros registros ---\n")
print(head(datos))
cat("\n--- Estructura ---\n")
str(datos)
cat("\n--- Faltantes por columna ---\n")
print(colSums(is.na(datos)))

filas_iniciales <- nrow(datos)
datos <- datos[complete.cases(datos), , drop = FALSE]
cat("Filas eliminadas por faltantes:", filas_iniciales - nrow(datos), "\n")

# Todas las variables son categóricas; se representan como factores.
datos[] <- lapply(datos, factor)
datos$clase <- droplevels(datos$clase)

cat("\n--- Resumen ---\n")
print(summary(datos))
cat("\n--- Frecuencias de la clase objetivo ---\n")
print(table(datos$clase))
print(round(100 * prop.table(table(datos$clase)), 2))
cat("Número de registros tras limpieza:", nrow(datos), "\n")

# En UCI, las etiquetas originales son unacc, acc, good y vgood.
# Se conservan sin traducir para no cambiar las etiquetas del dataset.

# 4. CONFIGURACIÓN ---------------------------------------------
# Tres particiones estratificadas 80/20. Los tres modelos usan las
# mismas particiones; solo cambia la semilla entre experimentos.
semillas <- c(123, 456, 789)
control_cv <- trainControl(method = "cv", number = 5)
metodos <- c(
  "Arbol de decision" = "rpart",
  "SVM radial" = "svmRadial",
  "Random Forest" = "rf"
)

if (!dir.exists("resultados")) dir.create("resultados")
resultados <- data.frame()

# 5. ENTRENAMIENTO Y EVALUACIÓN -------------------------------
for (i in seq_along(semillas)) {
  cat("\n========================================\n")
  cat("Particion", i, "- semilla", semillas[i], "\n")
  set.seed(semillas[i])

  indice <- createDataPartition(datos$clase, p = 0.80, list = FALSE)
  entrenamiento <- datos[indice, , drop = FALSE]
  prueba <- datos[-indice, , drop = FALSE]
  cat("Entrenamiento:", nrow(entrenamiento), " Prueba:", nrow(prueba), "\n")

  for (nombre in names(metodos)) {
    metodo <- unname(metodos[[nombre]])
    cat("\nEntrenando", nombre, "...\n")
    set.seed(semillas[i])

    modelo <- train(
      clase ~ ., data = entrenamiento, method = metodo,
      trControl = control_cv, tuneLength = 3
    )
    pred <- predict(modelo, newdata = prueba)
    pred <- factor(pred, levels = levels(prueba$clase))
    cm <- confusionMatrix(data = pred, reference = prueba$clase)
    print(cm)

    archivo_cm <- paste0(
      "resultados/matriz_particion_", i, "_",
      gsub("[^A-Za-z0-9]+", "_", nombre), ".txt"
    )
    writeLines(capture.output(print(cm)), archivo_cm)

    # En clasificación multiclase caret devuelve métricas por clase.
    sensibilidad_macro <- NA_real_
    especificidad_macro <- NA_real_
    if (is.matrix(cm$byClass)) {
      if ("Sensitivity" %in% colnames(cm$byClass)) {
        sensibilidad_macro <- mean(cm$byClass[, "Sensitivity"], na.rm = TRUE)
      }
      if ("Specificity" %in% colnames(cm$byClass)) {
        especificidad_macro <- mean(cm$byClass[, "Specificity"], na.rm = TRUE)
      }
    }

    resultados <- rbind(resultados, data.frame(
      particion = i,
      modelo = nombre,
      accuracy = unname(cm$overall["Accuracy"]),
      kappa = unname(cm$overall["Kappa"]),
      sensibilidad_macro = sensibilidad_macro,
      especificidad_macro = especificidad_macro
    ))

    # Visualización del árbol ajustado en la primera partición.
    if (nombre == "Arbol de decision" && i == 1) {
      png("resultados/arbol_decision.png", width = 1200, height = 900, res = 120)
      rpart.plot(modelo$finalModel, main = "Arbol de decision - particion 1")
      dev.off()
    }
  }
}

# 6. COMPARACIÓN ------------------------------------------------
cat("\n--- Resultados por modelo y partición ---\n")
print(resultados)
write.csv(resultados, "resultados/metricas_por_particion.csv", row.names = FALSE)

metricas <- c("accuracy", "kappa", "sensibilidad_macro", "especificidad_macro")
promedios <- aggregate(
  resultados[metricas],
  by = list(modelo = resultados$modelo),
  FUN = function(x) mean(x, na.rm = TRUE)
)
promedios <- promedios[order(-promedios$accuracy), ]
cat("\n--- Métricas promedio en las tres particiones ---\n")
print(promedios)
write.csv(promedios, "resultados/promedio_modelos.csv", row.names = FALSE)

cat("\nMayor Accuracy promedio:", as.character(promedios$modelo[1]), "\n")
cat(paste(
  "Use Accuracy como criterio inicial y revise también Kappa,",
  "sensibilidad/especificidad por clase, estabilidad e interpretabilidad.\n"
))

# 7. CONCLUSIÓN -------------------------------------------------
cat("\nComplete el informe con los resultados generados. No invente cifras.\n")
cat("Revise la carpeta resultados/ para tablas, matrices y gráfico.\n")
