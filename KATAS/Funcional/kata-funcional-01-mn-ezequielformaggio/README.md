# Primera kata para resolver

[![Build Status](https://www.travis-ci.com/pdep-mn-utn/kata-funcional-01-mn-ezequielformaggio.svg?token=CNUSaYABzXaBUqhD7TiK&branch=master)](https://www.travis-ci.com/pdep-mn-utn/kata-funcional-01-mn-ezequielformaggio)

Antes que nada, [¿qué es una kata?](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/katas/katas.md)

## Tareas

- [ ] Instalar [el entorno](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/entorno.md)
- [ ] [Aceptar el assignment y clonar el repositorio con el ejercicio](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/katas/katas-guia.md)
- [ ] Ir a la carpeta donde descargaste la kata. Ejemplo: `cd /home/dodain/haskell/mn-funcional-kata01`. Ejecutar `stack test` y verificar que tengas un mensaje verde que diga `El pdepreludat se instaló correctamente`
- [ ] Reemplazar la lista de integrantes con tu nombre
- [ ] Resolver el ejercicio siguiendo [un esquema de trabajo](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/trabajo.md), eso incluye
- [ ] Ejecutar los tests con `stack test` y que den verde
- [ ] Subir [tu solución a git](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/git/resolverConflictos.md)
- [ ] Ver el resultado de la ejecución en http://travis-ci.com siguiendo [estos pasos y agregando el badge del build](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/katas/kata-ci-travis.md)

## Integrante

- Formaggio Ezequiel

## Objetivos

La primera kata que preparamos para que resuelvan solos comparte los objetivos de la anterior

- verificar que tenés correctamente instalado el entorno
- familiarizarte con el uso del lenguaje Haskell y de la herramienta Visual Studio Code
- que entiendas el circuito básico de toda kata, bajando el enunciado desde un repositorio, completando el ejercicio y subiendo tu solución
- utilizar pruebas automatizadas para facilitar la validación del código que escribís

y de paso, fomentar el trabajo en equipo con un compañero, para comenzar a discutir ideas de programación en conjunto.

## Pre-requisitos

Necesitás instalar en tu notebook [el entorno Haskell](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/entorno.md)

## Ayuda

Si tenés dudas con Haskell podés ayudarte todo el tiempo con esta documentación

- [Guía de lenguajes](https://docs.google.com/document/d/1oJ-tyQJoBtJh0kFcsV9wSUpgpopjGtoyhJdPUdjFIJQ/edit?usp=sharing), un resumen de las principales funciones que vienen con Haskell
- [Hoogle](https://www.haskell.org/hoogle/), un motor de búsqueda específico para Haskell

Y para comenzar a trabajar con Git te recomendamos [este apunte inicial de Git](https://docs.google.com/document/d/1ozqfYCwt-37stynmgAd5wJlNOFKWYQeIZoeqXpAEs0I/edit). Una vez que estés familiarizado con el circuito, tenés un buen resumen de los comandos en las páginas 3 y 4 [de este apunte](https://docs.google.com/document/d/147cqUY86wWVoJ86Ce0NoX1R78CwoCOGZtF7RugUvzFg/edit#).

## El enunciado

Resolver la función `calcuLoco` que recibe dos números

- si el primer número es mayor que el segundo, devuelve la división de ambos números
- si no, si el primer número es impar, devuelve el segundo número menos 5
- en caso contrario, devuelve el doble del primer número 

## Pruebas manuales

Una vez resuelta la función `calcuLoco` podemos levantar el entorno Haskell:

```bash
stack ghci
```

Y dentro del intérprete podremos evaluar la función con diferentes valores:

```hs
*Main> calcuLoco 6 2
3.0
*Main> calcuLoco 5 7
2.0
*Main> calcuLoco 8 10
16.0
```

## Testeo automatizado

Nuestra solución tiene que estar escrita en el archivo `Library.hs` del directorio `src`, entonces podemos correr pruebas **automatizadas** para nuestra función `calcuLoco` en la terminal:

```bash
stack clean
stack test
```

También podés ejecutar una sesión interactiva en la terminal: `stack test --file-watch`, como muestra [esta página](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/trabajo.md).

Para conocer un poco más del testeo unitario automatizado recomendamos leer [este apunte](https://docs.google.com/document/d/17EPSZSw7oY_Rv2VjEX2kMZDFklMOcDVVxyve9HSG0mE/edit#)
