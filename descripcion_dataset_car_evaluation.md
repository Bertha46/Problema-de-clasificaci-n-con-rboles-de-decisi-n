# Base de datos de evaluación de automóviles (Car Evaluation)

## Información general

- **Título:** Car Evaluation Database
- **Creador:** Marko Bohanec
- **Donantes:** Marko Bohanec (marko.bohanec@ijs.si) y Blaz Zupan (blaz.zupan@ijs.si)
- **Fecha:** junio de 1997
- **Número de instancias:** 1.728; las instancias cubren por completo el espacio de atributos.
- **Número de atributos de entrada:** 6
- **Valores faltantes:** ninguno

## Origen y usos anteriores

El modelo jerárquico de decisión del que se deriva este conjunto de datos fue presentado originalmente por M. Bohanec y V. Rajkovic en *Knowledge acquisition and explanation for multi-attribute decision making*, en el 8.º Taller Internacional sobre Sistemas Expertos y sus Aplicaciones, celebrado en Aviñón, Francia, en 1988 (págs. 59–78).

En aprendizaje automático, el conjunto se utilizó para evaluar HINT (*Hierarchy INduction Tool*), una herramienta que logró reconstruir por completo el modelo jerárquico original. Este trabajo, junto con una comparación con C4.5, se presentó en B. Zupan, M. Bohanec, I. Bratko y J. Demsar, *Machine learning by function decomposition*, ICML-97, Nashville, Tennessee, 1997.

## Información relevante

La base de datos de evaluación de automóviles se deriva de un modelo jerárquico sencillo de toma de decisiones, desarrollado originalmente para demostrar DEX. El modelo evalúa los automóviles según esta estructura conceptual:

```text
CAR                       aceptabilidad del automóvil
├── PRICE                 precio total
│   ├── buying            precio de compra
│   └── maint             costo de mantenimiento
└── TECH                  características técnicas
    ├── COMFORT           comodidad
    │   ├── doors         número de puertas
    │   ├── persons       capacidad de pasajeros
    │   └── lug_boot      tamaño del maletero
    └── safety            seguridad estimada del automóvil
```

En el modelo original, cada concepto se relaciona con sus conceptos descendientes de nivel inferior mediante un conjunto de ejemplos. La base de datos elimina esa información estructural y relaciona directamente el concepto objetivo **CAR** con los seis atributos de entrada: `buying`, `maint`, `doors`, `persons`, `lug_boot` y `safety`.

Debido a que se conoce la estructura conceptual subyacente, este conjunto de datos puede ser especialmente útil para probar métodos de inducción constructiva y descubrimiento de estructuras.

Más información sobre los conjuntos de ejemplos del modelo: [página del modelo Car](http://www-ai.ijs.si/BlazZupan/car.html).

## Atributos y valores

| Atributo | Descripción | Valores |
|---|---|---|
| `buying` | Precio de compra | muy alto (`v-high`), alto (`high`), medio (`med`), bajo (`low`) |
| `maint` | Precio del mantenimiento | muy alto (`v-high`), alto (`high`), medio (`med`), bajo (`low`) |
| `doors` | Número de puertas | 2, 3, 4, 5 o más (`5-more`) |
| `persons` | Capacidad de pasajeros | 2, 4, más (`more`) |
| `lug_boot` | Tamaño del maletero | pequeño (`small`), mediano (`med`), grande (`big`) |
| `safety` | Seguridad estimada del automóvil | baja (`low`), media (`med`), alta (`high`) |

## Distribución de clases

| Clase | Instancias | Porcentaje |
|---|---:|---:|
| `unacc` (inaceptable) | 1.210 | 70,023 % |
| `acc` (aceptable) | 384 | 22,222 % |
| `good` (bueno) | 69 | 3,993 % |
| `v-good` (muy bueno) | 65 | 3,762 % |

## Referencias

- M. Bohanec y V. Rajkovic. “Knowledge acquisition and explanation for multi-attribute decision making”. 8th International Workshop on Expert Systems and their Applications, Aviñón, Francia, 1988, págs. 59–78.
- M. Bohanec y V. Rajkovic. “Expert system for decision making”. *Sistemica*, 1(1), 1990, págs. 145–157.
- B. Zupan, M. Bohanec, I. Bratko y J. Demsar. “Machine learning by function decomposition”. ICML-97, Nashville, Tennessee, 1997.
