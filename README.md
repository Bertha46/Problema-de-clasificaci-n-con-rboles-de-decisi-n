# Clasificación de automóviles con árboles de decisión

Proyecto de la Actividad 3: clasificación multiclase del dataset CAR con R.

## Archivos

- `actividad3_car.R`: script comentado para preparación, exploración, tres particiones 80/20, entrenamiento de árbol de decisión, SVM radial y Random Forest, matrices de confusión y comparación de métricas.
- `informe_actividad3.md`: guía del informe. Completar las métricas y conclusiones con la salida real del script.
- `problema_de_clasificacion_con_arboles_de_decision.md`: descripción inicial del proyecto.

## Uso rápido

1. Descargue el CSV CAR indicado por el curso (formato estándar UCI: siete columnas, usualmente sin encabezados).
2. Abra `actividad3_car.R` en RStudio, complete sus datos y ejecútelo.
3. Seleccione el CSV cuando se solicite.
4. Consulte `resultados/` para las matrices de confusión, CSV de métricas y gráfico.
5. Complete `informe_actividad3.md`. No presente métricas de ejemplo ni resultados no generados por su ejecución.

El script instala los paquetes R que falten. Las clases conservan las etiquetas originales UCI (`unacc`, `acc`, `good`, `vgood`) para evitar traducir o recodificar inadvertidamente la variable objetivo.
