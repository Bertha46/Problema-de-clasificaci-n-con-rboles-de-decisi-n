# Actividad 3 — Clasificación de automóviles con árboles de decisión

**Estudiante:** [Nombres y apellidos]  
**Asignatura:** [Asignatura]  
**Docente:** [Nombre del docente]  
**Fecha:** [Fecha de entrega]

## Objetivo

Preparar y explorar el conjunto de datos CAR, entrenar tres clasificadores y comparar su desempeño mediante matrices de confusión y métricas calculadas sobre datos de prueba. Los modelos incluidos son un árbol de decisión, una máquina de vectores de soporte (SVM radial) y Random Forest.

## Dataset

El conjunto Car Evaluation de UCI contiene 1.728 observaciones y siete columnas: seis atributos categóricos (`buying`, `maint`, `doors`, `persons`, `lug_boot`, `safety`) y una variable objetivo (`class`). En el script se utilizan nombres descriptivos en español/inglés: `precio_de_compra`, `maint_cost`, `puertas`, `person_capacity`, `lug_boot`, `seguridad` y `clase`.

Las etiquetas originales de la clase son `unacc`, `acc`, `good` y `vgood` (inaceptable, aceptable, bueno y muy bueno). Se conservan en el análisis para no alterar el significado de las etiquetas; si se traducen en el informe, debe aclararse la correspondencia.

## Ejecución

1. Descargue el archivo CSV de CAR indicado por el curso (o el archivo `car.data` de UCI). El archivo de UCI normalmente no incluye encabezados.
2. Abra `actividad3_car.R` en RStudio y complete los datos personales en el encabezado.
3. Ejecute el script y seleccione el CSV cuando aparezca el diálogo.
4. Revise la carpeta `resultados/`, que contiene las matrices de confusión por modelo y partición, las métricas en CSV y el gráfico del árbol.
5. Complete las tablas y conclusiones de este informe con las salidas reales generadas. No copie resultados de otras ejecuciones ni invente cifras.

## Preparación y metodología

Se inspeccionan la estructura, los primeros registros, los resúmenes, los valores faltantes y la distribución de la clase. Las columnas se convierten a factores porque los atributos son categóricos. Se eliminan únicamente filas con valores faltantes; el script informa cuántas se quitaron.

Se realizan tres particiones estratificadas 80/20 con semillas `123`, `456` y `789`. Para cada partición, los tres modelos utilizan exactamente los mismos conjuntos de entrenamiento y prueba. Se aplica validación cruzada de cinco pliegues dentro del entrenamiento. La prueba se reserva para evaluación y no se usa para ajustar el modelo.

## Modelos

- **Árbol de decisión (`rpart`):** produce reglas visualizables e interpretables; se guarda una gráfica de la primera partición.
- **SVM radial (`svmRadial`):** clasificador de margen con kernel radial; se ajusta mediante la validación cruzada indicada.
- **Random Forest (`rf`):** combina árboles y puede capturar interacciones; su interpretabilidad directa es menor que la de un árbol individual.

## Resultados (completar tras ejecutar el script)

### Métricas promedio en las tres particiones

Copie los resultados de `resultados/promedio_modelos.csv`:

| Modelo | Accuracy promedio | Kappa promedio | Sensibilidad macro promedio | Especificidad macro promedio |
|---|---:|---:|---:|---:|
| Árbol de decisión | [completar] | [completar] | [completar] | [completar] |
| SVM radial | [completar] | [completar] | [completar] | [completar] |
| Random Forest | [completar] | [completar] | [completar] | [completar] |

**Nota:** Accuracy es la proporción global de predicciones correctas. Kappa estima el acuerdo ajustado por azar. Sensibilidad y especificidad se resumen como promedio macro entre clases; consulte también las métricas por clase impresas por `confusionMatrix`, especialmente si las clases tienen tamaños distintos.

### Matrices de confusión

Incluya o resuma aquí las matrices generadas en `resultados/matriz_particion_*.txt`. Indique filas como clase real y columnas como clase predicha. Comente qué clases se confunden con mayor frecuencia y por qué podría ser importante.

### Interpretación y selección

El script ordena los modelos por Accuracy promedio como una ayuda inicial, no como una decisión automática. Justifique la elección considerando el conjunto de métricas, la estabilidad entre las tres particiones, los errores por clase y la necesidad de interpretabilidad. Si las métricas son similares, un árbol más interpretable puede ser preferible; si el desempeño global y por clase es claramente mejor en un modelo, explique la evidencia con los valores obtenidos.

**Modelo seleccionado:** [completar]  
**Justificación basada en resultados observados:** [completar]

## Conclusiones de aprendizaje

1. [Describa qué aprendió sobre importar, revisar y preparar datos categóricos.]
2. [Compare los resultados reales de los tres modelos y las clases con más errores.]
3. [Explique por qué seleccionó el modelo y qué limitaciones tiene la evaluación.]
4. [Indique una mejora futura, por ejemplo ajustar hiperparámetros o probar una validación adicional.]

## Limitaciones

Los resultados dependen del archivo utilizado, las versiones de R y paquetes, y las particiones aleatorias. La validación cruzada ayuda a ajustar cada modelo, pero la comparación final se basa en solo tres divisiones holdout; no constituye una garantía de desempeño en todos los datos futuros. La variable `clase` es la etiqueta objetivo del dataset, no una evaluación mecánica independiente del estado real de un automóvil.

## Referencias

- UCI Machine Learning Repository, *Car Evaluation*: https://archive.ics.uci.edu/dataset/19/car+evaluation
- `caret`: https://topepo.github.io/caret/
- `rpart`: https://cran.r-project.org/package=rpart
- `randomForest`: https://cran.r-project.org/package=randomForest
- `kernlab`: https://cran.r-project.org/package=kernlab
