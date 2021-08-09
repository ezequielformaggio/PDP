# Kata 4 - Orden superior y expresiones lambda

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

-  Formaggio Ezequiel (ezequielformaggio)

## Badge de Travis
  [![Build Status](https://travis-ci.com/pdep-mn-utn/kata-04-funcional-ezequielformaggio.svg?token=CNUSaYABzXaBUqhD7TiK&branch=master)](https://travis-ci.com/pdep-mn-utn/kata-04-funcional-ezequielformaggio)
  
## Objetivos

En esta kata el objetivo principal es trabajar sobre estos conceptos

- orden superior
- expresiones lambda
- siempre, siempre, siempre: reforzar el concepto de poner nombres representativos a las abstracciones: parámetros, función, etc.

## Pre-requisitos

Necesitás instalar en tu notebook [el entorno Haskell](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/entorno.md)

## Ayuda

Si tenés dudas con Haskell podés ayudarte todo el tiempo con esta documentación

- [Guía de lenguajes](https://docs.google.com/document/d/1oJ-tyQJoBtJh0kFcsV9wSUpgpopjGtoyhJdPUdjFIJQ/edit?usp=sharing), un resumen de las principales funciones que vienen con Haskell
- [Hoogle](https://www.haskell.org/hoogle/), un motor de búsqueda específico para Haskell

Y para comenzar a trabajar con Git te recomendamos [este apunte inicial de Git](https://docs.google.com/document/d/1ozqfYCwt-37stynmgAd5wJlNOFKWYQeIZoeqXpAEs0I/edit). Una vez que estés familiarizado con el circuito, tenés un buen resumen de los comandos en las páginas 3 y 4 [de este apunte](https://docs.google.com/document/d/147cqUY86wWVoJ86Ce0NoX1R78CwoCOGZtF7RugUvzFg/edit#).

## El enunciado

Encontrar las personas ambiciosas, que son aquellas que en sus sueños está la palabra "presidente" o "gobernar", no importa si está escrito en mayúsculas o minúsculas.

> **Tip 1:** te conviene importar la función Data.List.isInfixOf

> **Tip 2:** existe una función `toLower :: Char -> Char` que convierte letras de mayúsculas a minúsculas

**No se puede resolver ninguna función con recursividad**.

## Pruebas manuales

Las personas gogo y daenerys deben ser ambiciosas, el resto no.

## Testeo automatizado

Nuestra solución tiene que estar escrita en el archivo `Library.hs` del directorio `src`, entonces podemos correr pruebas **automatizadas** para nuestra función `calcuLoco` en la terminal:

```bash
stack clean
stack test
```

También podés ejecutar una sesión interactiva en la terminal: `stack test --file-watch`, como muestra [esta página](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/trabajo.md).

Para conocer un poco más del testeo unitario automatizado recomendamos leer [este apunte](https://docs.google.com/document/d/17EPSZSw7oY_Rv2VjEX2kMZDFklMOcDVVxyve9HSG0mE/edit#)

