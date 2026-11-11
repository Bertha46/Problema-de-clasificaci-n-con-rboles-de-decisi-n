# Clasificación de automóviles con el conjunto de datos Car Evaluation

**Estudiante:** Bertha Mero  
**Asignatura:** ______________________________  
**Docente:** ______________________________  
**Fecha:** ______________________________

## 1. Introducción

La clasificación es una técnica de aprendizaje automático que permite asignar una categoría a cada registro a partir de sus características. En este trabajo se utiliza el conjunto de datos **Car Evaluation** para clasificar la aceptabilidad de automóviles según su precio, mantenimiento, capacidad, tamaño del maletero y seguridad.

Se entrenan y comparan tres modelos: árbol de decisión, máquina de vectores de soporte (SVM) y Random Forest. El análisis se realiza en R y evalúa cada modelo mediante particiones de entrenamiento y prueba, matrices de confusión y métricas de clasificación.

## 2. Descripción del conjunto de datos

Car Evaluation Database fue creado por Marko Bohanec y publicado en junio de 1997. Contiene **1.728 registros**, seis atributos de entrada y una variable objetivo. No presenta valores faltantes y cubre todas las combinaciones posibles de sus atributos.

El conjunto deriva de un modelo jerárquico de decisión desarrollado para demostrar DEX. En dicho modelo, la aceptabilidad general del automóvil se relaciona con conceptos intermedios como precio y características técnicas. La base de datos utilizada en este trabajo relaciona directamente la clase del automóvil con sus seis atributos de entrada.

### Atributos

| Atributo | Descripción | Valores |
|---|---|---|
| `buying` | Precio de compra | Muy alto, alto, medio, bajo |
| `maint` | Costo de mantenimiento | Muy alto, alto, medio, bajo |
| `doors` | Número de puertas | 2, 3, 4, 5 o más |
| `persons` | Capacidad de pasajeros | 2, 4, más |
| `lug_boot` | Tamaño del maletero | Pequeño, mediano, grande |
| `safety` | Seguridad estimada | Baja, media, alta |
| `clase` | Aceptabilidad del automóvil (variable objetivo) | Inaceptable, aceptable, bueno, muy bueno |

### Distribución de las clases

| Clase | Registros | Porcentaje |
|---|---:|---:|
| Inaceptable (`unacc`) | 1.210 | 70,023 % |
| Aceptable (`acc`) | 384 | 22,222 % |
| Bueno (`good`) | 69 | 3,993 % |
| Muy bueno (`vgood`) | 65 | 3,762 % |
| **Total** | **1.728** | **100 %** |

## 3. Objetivo del trabajo

Desarrollar y comparar modelos de clasificación que permitan predecir la aceptabilidad de un automóvil a partir de sus características categóricas. Se busca identificar el modelo con mejor desempeño y analizar los errores que comete al clasificar los registros.

## 4. Preparación y exploración de los datos

Los datos se cargan desde el repositorio de UCI Machine Learning Repository. Después se revisan sus dimensiones, estructura, resumen de variables, valores faltantes y distribución de clases.

Las variables se convierten en factores porque representan categorías y no cantidades numéricas continuas. Antes del entrenamiento también se comprueba que los registros y niveles de las categorías sean los esperados.

El conjunto se divide en datos de entrenamiento y de prueba. Se realizan tres particiones reproducibles, cada una con aproximadamente **80 % de los registros para entrenamiento y 20 % para prueba**. La partición estratificada conserva, en la medida de lo posible, la proporción de las clases en ambos grupos.

## 5. Modelos utilizados

### 5.1 Árbol de decisión

El árbol de decisión organiza las reglas de clasificación en una estructura de ramas. Su principal ventaja es que resulta relativamente fácil de interpretar y permite observar qué condiciones conducen a una predicción. Sin embargo, puede ser sensible a los datos utilizados y llegar a sobreajustarse.

### 5.2 Máquina de vectores de soporte (SVM)

La SVM busca separar las clases mediante límites que permitan distinguir los registros. En este trabajo se utiliza una SVM lineal. Como el modelo puede verse afectado por la escala de las variables, el procedimiento incluye el preprocesamiento correspondiente dentro del entrenamiento.

### 5.3 Random Forest

Random Forest combina varios árboles de decisión y reúne sus predicciones para obtener una clasificación. Además de evaluar su desempeño, se puede examinar la importancia de las variables estimada por el modelo. Aunque suele ser menos sencillo de interpretar que un árbol individual, permite comparar el aporte de diferentes atributos.

## 6. Evaluación de los modelos

Cada modelo se entrena usando validación cruzada de cinco pliegues dentro del conjunto de entrenamiento. Luego se realizan predicciones sobre el conjunto de prueba de cada partición.

Para evaluar el desempeño se utilizan las siguientes métricas:

- **Exactitud (accuracy):** proporción de predicciones correctas.
- **Kappa:** compara el acuerdo entre las predicciones y las clases reales, considerando el acuerdo esperado por azar.
- **Sensibilidad:** mide qué proporción de los casos reales de una clase fue identificada correctamente.
- **Especificidad:** mide qué proporción de los casos que no pertenecen a una clase fue reconocida correctamente.
- **Matriz de confusión:** muestra las clases reales frente a las clases predichas y ayuda a identificar los tipos de error.

### Resultados obtenidos

Completa esta tabla con los valores generados al ejecutar el análisis en R:

| Modelo | Exactitud promedio | Kappa promedio | Sensibilidad macro promedio | Especificidad macro promedio |
|---|---:|---:|---:|---:|
| Árbol de decisión | ______ | ______ | ______ | ______ |
| SVM lineal | ______ | ______ | ______ | ______ |
| Random Forest | ______ | ______ | ______ | ______ |

Las métricas se promedian a partir de las tres particiones. La selección final debe considerar el conjunto de métricas y no solamente la exactitud, ya que el dataset presenta un desbalance entre las clases.

## 7. Análisis de resultados

Al comparar los modelos, se debe revisar cuál obtiene mejores resultados de manera consistente en las tres particiones. También es importante observar la matriz de confusión de cada modelo para identificar qué clases se confunden con mayor frecuencia.

La clase “inaceptable” es la más representada, mientras que “bueno” y “muy bueno” tienen muchos menos registros. Por ello, un modelo podría alcanzar una exactitud alta y, al mismo tiempo, clasificar de manera menos precisa las clases minoritarias. La sensibilidad por clase permite analizar este aspecto con mayor detalle.

El árbol de decisión ofrece una representación más interpretable de las reglas. Random Forest permite analizar la importancia de las variables y combina múltiples árboles. La SVM aporta una alternativa de clasificación basada en límites de separación. La conveniencia de cada modelo depende de las métricas obtenidas y de si se prioriza el rendimiento general o la facilidad de interpretación.

## 8. Conclusiones

El conjunto Car Evaluation permite estudiar un problema de clasificación con atributos categóricos y una variable objetivo con cuatro clases. La exploración inicial permite conocer la estructura de los datos, confirmar la ausencia de valores faltantes y observar el desbalance de clases.

El trabajo compara un árbol de decisión, una SVM lineal y Random Forest utilizando tres particiones reproducibles y validación cruzada durante el entrenamiento. Para seleccionar el modelo más adecuado se deben considerar la exactitud, Kappa, sensibilidad, especificidad y las matrices de confusión.

**Conclusión final sobre el modelo seleccionado:** Al completar la ejecución del análisis, el modelo seleccionado fue **____________________________**, porque obtuvo **____________________________** en las métricas evaluadas. También se observó que **____________________________**.

## 9. Referencias

- Bohanec, M. y Rajkovic, V. “Knowledge acquisition and explanation for multi-attribute decision making”. *8th International Workshop on Expert Systems and their Applications*, Aviñón, Francia, 1988, págs. 59–78.
- Bohanec, M. y Rajkovic, V. “Expert system for decision making”. *Sistemica*, 1(1), 1990, págs. 145–157.
- Zupan, B., Bohanec, M., Bratko, I. y Demsar, J. “Machine learning by function decomposition”. ICML-97, Nashville, Tennessee, 1997.
- UCI Machine Learning Repository. [Car Evaluation Data Set](https://archive.ics.uci.edu/dataset/19/car+evaluation).
