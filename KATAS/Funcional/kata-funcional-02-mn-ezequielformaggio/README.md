# Kata 2 - Composición. Aplicación parcial

[![Build Status](https://www.travis-ci.com/pdep-mn-utn/kata-funcional-02-mn-ezequielformaggio.svg?token=CNUSaYABzXaBUqhD7TiK&branch=master)](https://www.travis-ci.com/pdep-mn-utn/kata-funcional-02-mn-ezequielformaggio)

## Tareas

- [ ] Instalar [el entorno](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/entorno.md), si no lo hiciste antes
- [ ] [Aceptar el assignment y clonar el repositorio con el ejercicio](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/katas/katas-guia.md)
- [ ] Ir a la carpeta donde descargaste la kata. Ejemplo: `cd /home/dodain/haskell/mn-funcional-kata02`. Ejecutar `stack test` y verificar que tengas un mensaje verde que diga `El pdepreludat se instaló correctamente`
- [ ] Reemplazar la lista de integrantes con tu nombre
- [ ] Resolver el ejercicio siguiendo [un esquema de trabajo](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/trabajo.md), eso incluye
- [ ] Ejecutar los tests con `stack test` y que den verde
- [ ] Subir [tu solución a git](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/git/resolverConflictos.md)
- [ ] Ver el resultado de la ejecución en http://travis-ci.com siguiendo [estos pasos y agregando el badge del build](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/katas/kata-ci-travis.md)

## Integrante

- Formaggio Ezequiel (ezequielformaggio)
  
## Objetivos

En esta kata el objetivo principal es trabajar sobre estos conceptos

- composición
- aplicación parcial
- reforzar el concepto de poner nombres representativos a las abstracciones: parámetros, función, etc.

## Pre-requisitos

Asumimos que alguno de los dos integrantes ya tiene en su notebook el entorno Haskell. De no ser así, necesitás [seguí estas instrucciones.](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/entorno.md)

## Ayuda

Si tenés dudas con Haskell podés ayudarte todo el tiempo con esta documentación

- [Guía de lenguajes](https://docs.google.com/document/d/1oJ-tyQJoBtJh0kFcsV9wSUpgpopjGtoyhJdPUdjFIJQ/edit?usp=sharing), un resumen de las principales funciones que vienen con Haskell
- [Hoogle](https://www.haskell.org/hoogle/), un motor de búsqueda específico para Haskell

Y para comenzar a trabajar con Git te recomendamos [este apunte inicial de Git](https://docs.google.com/document/d/1ozqfYCwt-37stynmgAd5wJlNOFKWYQeIZoeqXpAEs0I/edit). Una vez que estés familiarizado con el circuito, tenés un buen resumen de los comandos en las páginas 3 y 4 [de este apunte](https://docs.google.com/document/d/147cqUY86wWVoJ86Ce0NoX1R78CwoCOGZtF7RugUvzFg/edit#).

## Los ejercicios (deben resolverse únicamente con composición y aplicación parcial)

Modelamos una materia como una tupla donde

- el primer elemento representa el nombre de la materia
- y el segundo la cantidad de parciales que tiene

### Materia copada

Saber si una materia es copada, esto implica que su nombre tiene una cantidad de letras par. **Algunas pruebas**:

```hs
*Main> materiaCopada ("Paradigmas de Programación", 2500)
True

*Main> materiaCopada ("Computación", 2501)
False
```

### Problemas de cupo

Saber si una materia tiene problemas de cupo: esto se da cuando la cantidad de inscriptos supera el 50% de los 5.000 alumn@s regulares que hoy tiene la facultad.

```hs
*Main> tieneProblemasDeCupo ("Paradigmas de Programación", 2500)
False

*Main> tieneProblemasDeCupo ("Computación", 2501)
True
```

> Recuerden que es obligatorio el uso de **composición** y **aplicación parcial** para aprobar la kata

## Testeo automatizado

Nuestra solución tiene que estar escrita en el archivo `Library.hs` del directorio `src`, entonces podemos correr pruebas **automatizadas** para nuestra función `calcuLoco` en la terminal:

```bash
stack clean
stack test
```

También podés ejecutar una sesión interactiva en la terminal: `stack test --file-watch`, como muestra [esta página](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/trabajo.md).

Para conocer un poco más del testeo unitario automatizado recomendamos leer [este apunte](https://docs.google.com/document/d/17EPSZSw7oY_Rv2VjEX2kMZDFklMOcDVVxyve9HSG0mE/edit#)
