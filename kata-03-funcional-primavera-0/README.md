# Kata: Orden Superior (map, filter, ...)

## Tareas

- [ ] [Aceptar el assignment y clonar el repositorio con el ejercicio](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/katas/katas-guia.md)
- [ ] Editar el archivo README.md y reemplazar la lista de integrantes con tu nombre
- [ ] Resolver el ejercicio siguiendo [el esquema de trabajo](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/trabajo.md), eso incluye
- [ ] Ejecutar los tests con `stack test` y que den verde
- [ ] Subir [tu solución a git](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/git/resolverConflictos.md)
- [ ] Ver el resultado de la ejecución en http://travis-ci.com siguiendo [estos pasos y agregando el badge del build](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/katas/kata-ci-travis.md)


## Badge de Travis

[![Build Status](https://travis-ci.com/pdep-mn-utn/kata-03-funcional-primavera-0.svg?token=7zzBtZipH2kXWuhfRdUe&branch=master)](https://travis-ci.com/pdep-mn-utn/kata-03-funcional-primavera-0)

## Integrantes

- Almiron Laura Andrea (lalmiron)
- Formaggio Ezequiel (ezequielformaggio)
  
## Objetivos

En esta kata el objetivo principal es trabajar el concepto de Orden Superior en conjunto con otros vistos anteriormente, como

- composición
- aplicación parcial
- definición de funciones propias

además del trabajo en equipo.

## Pre-requisitos

Necesitás instalar en tu notebook [el entorno Haskell](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/entorno.md)

## Ayuda

Si tenés dudas con Haskell podés ayudarte todo el tiempo con esta documentación

- [Guía de lenguajes](https://docs.google.com/document/d/1oJ-tyQJoBtJh0kFcsV9wSUpgpopjGtoyhJdPUdjFIJQ/edit?usp=sharing), un resumen de las principales funciones que vienen con Haskell
- [Hoogle](https://www.haskell.org/hoogle/), un motor de búsqueda específico para Haskell

Y para comenzar a trabajar con Git te recomendamos [este apunte inicial de Git](https://docs.google.com/document/d/1ozqfYCwt-37stynmgAd5wJlNOFKWYQeIZoeqXpAEs0I/edit). Una vez que estés familiarizado con el circuito, tenés un buen resumen de los comandos en las páginas 3 y 4 [de este apunte](https://docs.google.com/document/d/147cqUY86wWVoJ86Ce0NoX1R78CwoCOGZtF7RugUvzFg/edit#).

## Enunciado

Tenemos una estructura de Persona de la cual se sabe la edad, el sueldo y los elementos que posee. Además contamos con una lista de personas y queremos saber:

### Integrante 1

- **cuantoPonemosDePrepaga**: dada una lista de empleados, queremos calcular el 11% de la sumatoria de los sueldos de las personas mayores a 26 años.

### Integrante 2

- **genteCabulera**: dada una lista de personas, conocer el conjunto de personas cuya longitud de todos los nombres de los elementos que poseen sea par. Ejemplo: si una persona tiene "mazo de cartas" y "victorinox", suman 24 => cumple la condición. Si tiene "alhaja" y "piedras", suman 6 + 7 = 13 => no cumple la condición. La cantidad de cosas que posee una persona no es fija, pueden ser 0, 1, 3 ó 77 cosas.

### Ambos

Dadas las funciones auxiliares 

```haskell
perderElemento:: String -> Persona -> Persona
perderElemento nombreElemento persona = persona {
  elementos = filter (/=nombreElemento) $ elementos persona
}

cumplirAnios:: Persona -> Persona
cumplirAnios persona = persona { edad = 1 + edad persona }

incrementarSueldo:: Number -> Persona -> Persona
incrementarSueldo factor persona = persona { 
  sueldo = sueldo persona  * factor
}

modificacionesLocas:: [Persona -> Persona]
modificacionesLocas = [perderElemento "teclado", cumplirAnios , incrementarSueldo 1.2]
```

- **alterarEmpleado** que dado un empleado y una lista de **modificacionesLocas** las aplica en el empleado.


## Testeo automatizado

Nuestra solución tiene que estar escrita en el archivo `Library.hs` del directorio `src`, entonces podemos correr pruebas **automatizadas** para nuestra función `calcuLoco` en la terminal:

```bash
stack clean
stack test
```

También podés ejecutar una sesión interactiva en la terminal: `stack test --file-watch`, como muestra [esta página](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/trabajo.md).

Para conocer un poco más del testeo unitario automatizado recomendamos leer [este apunte](https://docs.google.com/document/d/17EPSZSw7oY_Rv2VjEX2kMZDFklMOcDVVxyve9HSG0mE/edit#)
