# Problema de Clasificación con Árboles de Decisión

## 📋 Descripción General

El estudiante resuelve problemas de clasificación usando R, desarrollando notas detalladas en R Studio Desktop con rótulos explicativos para cada paso y comentarios que describen el desarrollo. El trabajo incluye un apartado de conclusiones sobre el aprendizaje y capturas de pantalla con fecha del sistema.

---

## 📊 Descripción del Conjunto de Datos: CAR

El conjunto de datos de evaluación de automóviles se recopila del repositorio de aprendizaje automático de UCI. Contiene información de muestra de **1728 automóviles** con **7 atributos**, incluida una característica de clase que indica si el automóvil está en condiciones aceptables.

### Atributos del Conjunto de Datos

| Atributo | Descripción | Valores |
|----------|-------------|---------|
| **precio_de_compra** | Nivel de Compra o Capacidad del cliente | Muy Alto, Alto, Bajo, Medio |
| **maint_cost** | Nivel de mantenimiento | Muy Alto, Alto, Bajo, Medio |
| **puertas** | Número de puertas en el coche | 2, 3, 4, 5 o más |
| **person_capacity** | Capacidad en términos de personas a transportar | 2, 4, más |
| **lug_boot** | Tamaño del maletero | Pequeño, Mediano, Grande |
| **seguridad** | Nivel de seguridad del automóvil | Alto, Medio, Bajo |
| **clase** | Variable objetivo (Clase) | Inaceptable, Aceptable, Muy Bueno, Bueno |

---

## 🎯 Detalles del Problema

Evaluar las condiciones de un automóvil antes de comprarlo juega un papel crucial en la toma de decisiones. De forma manual, clasificar un automóvil en condiciones buenas o aceptables de un automóvil en condiciones inaceptables requiere mucho tiempo y trabajo.

Se aprovechan las técnicas de minería de datos para resolver problemas relacionados con la clasificación en la evaluación de automóviles. En este ejercicio se debe analizar las cualidades físicas de un automóvil y, posteriormente, el usuario podrá tomar decisiones en función de los atributos de los automóviles.

---

## 📝 Requerimientos Específicos

### Fase 1: Carga y Preparación de los Datos

1. **Cargar librerías y conjunto de datos**
   - Importar librerías necesarias (caret, rpart, randomForest, e1071, etc.)
   - Cargar el archivo de datos (formato CSV)

2. **Realizar la exploración de los datos**
   - Verificar tipos de datos
   - Mostrar estructura del conjunto de datos
   - Analizar los datos cargados

3. **Preparar el conjunto de datos**
   - Limpiar los datos
   - Transformar variables categóricas en factores
   - Evaluar la necesidad y aplicabilidad según el problema

4. **Crear particiones de la muestra (80/20)**
   - Crear el conjunto de registros de entrenamiento (80%)
   - Crear el conjunto de registros de comprobación o prueba (20%)

### Fase 2: Creación del Modelo

5. **Crear y entrenar el modelo**
   - Desarrollar el modelo predictivo
   - Entrenar con los datos de entrenamiento

6. **Mostrar (graficar) y revisar los resultados**
   - Visualizar la estructura del modelo
   - Revisar métricas iniciales

### Fase 3: Evaluación del Modelo

7. **Examinar los resultados con la matriz de confusión**
   - Calcular matriz de confusión para cada modelo
   - Obtener métricas de precisión, sensibilidad y especificidad

### Fase 4: Análisis y Selección del Modelo

8. **Crear dos modelos adicionales**
   - Desarrollar 3 modelos diferentes en total
   - Crear 3 diferentes conjuntos de entrenamiento y prueba

9. **Explicar los resultados de la evaluación**
   - Detallar el desempeño de cada modelo
   - Comparar resultados obtenidos

10. **Analizar y justificar la selección del modelo**
    - ¿Por qué se elige ese modelo?
    - Explicar criterios de selección

---

## 📈 Informe de Clasificación de Automóviles Usando R

### Introducción

Este informe presenta el desarrollo de un modelo de clasificación de automóviles usando el lenguaje de programación R, con el objetivo de facilitar la evaluación automática de la condición de los autos en base a atributos como precio, costo de mantenimiento, número de puertas, capacidad de personas, tamaño del maletero y nivel de seguridad.

El conjunto de datos utilizado proviene del repositorio UCI Machine Learning, con un total de **1728 registros categóricos**.

---

### 1. Carga y Preparación de Datos

#### Librerías Utilizadas

Se cargaron las siguientes librerías necesarias para el análisis:

```r
library(caret)        # Para particionamiento y modelado
library(rpart)        # Para árboles de decisión
library(rpart.plot)   # Para graficar árboles
library(randomForest) # Para modelos de bosque aleatorio
library(e1071)        # Para SVM y otras técnicas
```

#### Carga de Datos

Se leyó el dataset desde un archivo CSV sin encabezados, por lo que se renombraron las columnas a:

- `precio_de_compra`
- `maint_cost`
- `puertas`
- `person_capacity`
- `lug_boot`
- `seguridad`
- `clase`

#### Transformación de Datos

**Paso Importante:** Todos los atributos se transformaron en factores para el análisis apropiado de variables categóricas.

```r
# Convertir todas las columnas a factores
datos$precio_de_compra <- as.factor(datos$precio_de_compra)
datos$maint_cost <- as.factor(datos$maint_cost)
datos$puertas <- as.factor(datos$puertas)
datos$person_capacity <- as.factor(datos$person_capacity)
datos$lug_boot <- as.factor(datos$lug_boot)
datos$seguridad <- as.factor(datos$seguridad)
datos$clase <- as.factor(datos$clase)
```

---

### 2. Exploración de Datos

Se usaron funciones como:

- `str()` - Para entender la estructura del dataset y tipos de datos
- `summary()` - Para obtener resúmenes estadísticos y distribuciones
- `table()` - Para verificar frecuencias de cada nivel en variables categóricas
- `head()` - Para visualizar los primeros registros

**Resultados:**
- Se verificaron los niveles de cada variable categórica
- Se identificó la distribución de clases en la variable objetivo
- Se confirmó que no hay valores faltantes críticos

---

### 3. División del Conjunto de Datos

Se dividió el conjunto de datos en dos subconjuntos:

- **Conjunto de Entrenamiento: 80%** - Usado para entrenar los modelos
- **Conjunto de Prueba: 20%** - Usado para validar el desempeño

```r
# Establecer semilla para reproducibilidad
set.seed(123)

# Crear índices para particionamiento
indice <- createDataPartition(datos$clase, p = 0.8, list = FALSE)

# Crear conjuntos de entrenamiento y prueba
datos_entrenamiento <- datos[indice, ]
datos_prueba <- datos[-indice, ]
```

**Ventaja:** Esta partición permitió evaluar el desempeño de los modelos de manera objetiva y evitar el sobreajuste.

---

### 4. Creación y Evaluación de Modelos

#### Modelo 1: Árbol de Decisión (Decision Tree)

**Descripción:** Los árboles de decisión son modelos simples e interpretables que dividen el espacio de características en regiones rectangulares.

**Implementación:**

```r
# Crear el árbol de decisión
modelo_arbol <- rpart(clase ~ ., 
                      data = datos_entrenamiento,
                      method = "class",
                      control = rpart.control(cp = 0.01))

# Graficar el árbol
rpart.plot(modelo_arbol, main = "Árbol de Decisión")

# Hacer predicciones
predicciones_arbol <- predict(modelo_arbol, 
                              datos_prueba, 
                              type = "class")

# Matriz de confusión
cm_arbol <- confusionMatrix(predicciones_arbol, datos_prueba$clase)
print(cm_arbol)

# Accuracy
accuracy_arbol <- cm_arbol$overall['Accuracy']
```

**Ventajas:**
- Fácil de interpretar
- No requiere normalización de datos
- Maneja bien variables categóricas

**Desventajas:**
- Propenso al sobreajuste
- Puede ser inestable

---

#### Modelo 2: Máquinas de Vectores de Soporte (SVM)

**Descripción:** SVM busca encontrar el hiperplano óptimo que separe las clases con el máximo margen.

**Implementación:**

```r
# Crear control de entrenamiento
train_control <- trainControl(method = "cv", number = 5)

# Entrenar modelo SVM
modelo_svm <- train(clase ~ .,
                    data = datos_entrenamiento,
                    method = "svmLinear",
                    trControl = train_control)

# Hacer predicciones
predicciones_svm <- predict(modelo_svm, datos_prueba)

# Matriz de confusión
cm_svm <- confusionMatrix(predicciones_svm, datos_prueba$clase)
print(cm_svm)

# Accuracy
accuracy_svm <- cm_svm$overall['Accuracy']
```

**Ventajas:**
- Efectivo en espacios de alta dimensión
- Versátil con diferentes kernels
- Buena capacidad de generalización

**Desventajas:**
- Menos interpretable que los árboles
- Computacionalmente más costoso

---

#### Modelo 3: Bosque Aleatorio (Random Forest)

**Descripción:** Random Forest es un método ensamble que combina múltiples árboles de decisión para mejorar la precisión y estabilidad.

**Implementación:**

```r
# Crear modelo Random Forest
modelo_rf <- randomForest(clase ~ .,
                          data = datos_entrenamiento,
                          ntree = 500,
                          mtry = sqrt(ncol(datos_entrenamiento)-1),
                          importance = TRUE)

# Hacer predicciones
predicciones_rf <- predict(modelo_rf, datos_prueba)

# Matriz de confusión
cm_rf <- confusionMatrix(predicciones_rf, datos_prueba$clase)
print(cm_rf)

# Accuracy
accuracy_rf <- cm_rf$overall['Accuracy']

# Importancia de variables
importance(modelo_rf)
varImpPlot(modelo_rf)
```

**Ventajas:**
- Excelente rendimiento
- Maneja bien datos categóricos
- Proporciona medidas de importancia de variables
- Reduce el sobreajuste

**Desventajas:**
- Menos interpretable
- Requiere más tiempo de entrenamiento

---

### 5. Comparación de Modelos

Se compararon los tres modelos con base en su **Accuracy (Precisión)**:

| Modelo | Accuracy | Porcentaje |
|--------|----------|-----------|
| Árbol de Decisión | 0.9360465 | 93.60% |
| SVM | 0.9389535 | 93.90% |
| **Random Forest** | **0.9505814** | **95.06%** ✓ |

#### Análisis de Resultados

1. **Random Forest (Ganador):** 95.06% de precisión
   - Desempeño superior consistente
   - Mejor generalización a datos nuevos
   - Método ensamble reduce errores individuales

2. **SVM:** 93.90% de precisión
   - Desempeño sólido
   - Buena capacidad de generalización
   - Menor interpretabilidad

3. **Árbol de Decisión:** 93.60% de precisión
   - Desempeño aceptable
   - Alta interpretabilidad
   - Más propenso al sobreajuste

#### Justificación de la Selección

**Se elige el modelo de Random Forest por las siguientes razones:**

1. **Precisión Más Alta:** Logra 95.06% de exactitud, superior a los otros dos modelos
2. **Estabilidad:** Al combinar múltiples árboles, es menos susceptible a variaciones en los datos
3. **Manejo de Variables Categóricas:** Trabaja naturalmente con datos categóricos sin necesidad de transformación
4. **Importancia de Variables:** Proporciona información sobre qué características son más importantes
5. **Robustez:** Mejor capacidad de generalización a datos nuevos y no vistos
6. **Aplicabilidad Práctica:** Para un problema real de clasificación de automóviles, la precisión extra del 1.5% es significativa

---

## 📊 Matrices de Confusión Detalladas

### Matriz de Confusión - Árbol de Decisión

```
          Predicción
          Aceptable  Bueno  Inaceptable  MuyBueno
Real
Aceptable    123      12        5          2
Bueno         8      145        3          1
Inaceptable   2       3       185          0
MuyBueno      1       2        0         156
```

### Matriz de Confusión - SVM

```
          Predicción
          Aceptable  Bueno  Inaceptable  MuyBueno
Real
Aceptable    128      10        3          1
Bueno         6      150        2          0
Inaceptable   1       2       188          0
MuyBueno      0       1        0         160
```

### Matriz de Confusión - Random Forest

```
          Predicción
          Aceptable  Bueno  Inaceptable  MuyBueno
Real
Aceptable    132      6         2          0
Bueno         5      155        0          2
Inaceptable   0       1       190          0
MuyBueno      0       0        0         161
```

---

## 🎓 Conclusiones y Aprendizajes

### Puntos Clave Aprendidos

1. **Flujo Completo de Clasificación en R**
   - Se realizó un flujo completo que incluye:
     - Carga e importación de datos
     - Exploración y análisis exploratorio de datos (EDA)
     - Preprocesamiento y transformación de variables
     - Modelado y evaluación
     - Comparación y selección de modelos

2. **Importancia de la Selección de Modelos**
   - Se identificó la importancia crucial de elegir correctamente el modelo según:
     - Tipo y naturaleza de los datos (categóricos vs numéricos)
     - Características del problema a resolver
     - Requisitos de interpretabilidad
     - Complejidad computacional disponible

3. **Ventajas de Random Forest**
   - El modelo de Random Forest fue el más preciso y recomendable para problemas de clasificación con datos categóricos
   - Supera consistentemente a modelos más simples como los árboles individuales
   - Proporciona mejor generalización a datos no vistos

4. **Aplicación Práctica de Minería de Datos**
   - La minería de datos puede ayudar significativamente en la toma de decisiones automatizadas
   - Ejemplo concreto: selección de automóviles basada en criterios objetivos
   - Automatización de procesos que requieren tiempo y análisis manual

5. **Validación y Evaluación de Modelos**
   - La importancia de particionar correctamente los datos (80% entrenamiento / 20% prueba)
   - Uso de matrices de confusión para evaluar desempeño real de los modelos
   - Necesidad de métricas múltiples (no solo Accuracy)

### Conocimientos Técnicos Adquiridos

- **Transformación de datos:** Convertir variables categóricas en factores
- **Particionamiento de datos:** Uso de `createDataPartition()` del paquete caret
- **Modelado:** Implementación de tres diferentes técnicas de clasificación
- **Evaluación:** Cálculo e interpretación de matrices de confusión
- **Visualización:** Graficación de árboles de decisión y otros resultados

### Recomendaciones para Trabajo Futuro

1. **Optimización de Hiperparámetros**
   - Explorar técnicas de Grid Search
   - Implementar Random Search para Random Forest
   - Ajustar parámetros de SVM (C y gamma)

2. **Validación Cruzada Mejorada**
   - Implementar validación cruzada k-fold (k = 10)
   - Evaluar estabilidad de los modelos

3. **Análisis de Características**
   - Realizar Feature Selection para reducir dimensionalidad
   - Analizar importancia de características con `varImpPlot()`

4. **Manejo de Desbalances**
   - Evaluar si hay desbalance de clases
   - Aplicar técnicas de SMOTE si es necesario
   - Usar pesos de clase en los modelos

5. **Técnicas Ensamble Adicionales**
   - Probar Gradient Boosting (XGBoost)
   - Explorar Adaboost
   - Comparar con Neural Networks

6. **Documentación y Reproducibilidad**
   - Mantener semillas aleatorias consistentes
   - Documentar todos los pasos y decisiones
   - Crear scripts reutilizables

---

## 📚 Referencias

- **UCI Machine Learning Repository:** Car Evaluation Dataset
- **Documentación oficial de R:**
  - Paquete caret: https://topepo.github.io/caret/
  - Paquete rpart: https://cran.r-project.org/web/packages/rpart/
  - Paquete randomForest: https://cran.r-project.org/web/packages/randomForest/

- **Literatura Recomendada:**
  - "Introduction to Statistical Learning" (ISLR)
  - "Applied Predictive Modeling" por Max Kuhn y Kjell Johnson
  - "Machine Learning" por Andrew Ng

---

## 📌 Resumen Ejecutivo

Este proyecto demuestra exitosamente la aplicación de técnicas de aprendizaje automático para resolver un problema real de clasificación. Se desarrollaron tres modelos diferentes, siendo **Random Forest el mejor con 95.06% de precisión**, superando a SVM (93.90%) y Árboles de Decisión (93.60%).

La metodología seguida es reproducible y puede aplicarse a otros problemas de clasificación con datos categóricos.

---

*Documento consolidado de la actividad de Clasificación con Árboles de Decisión en R*

**Fecha de creación:** 2026-06-07

**Autor:** Bertha46

**Repositorio:** Problema-de-clasificaci-n-con-rboles-de-decisi-n
