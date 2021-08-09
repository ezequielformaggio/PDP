:- begin_tests(jouar).

  test(fakeTest):-
    A is 1 + 2,
    A =:= 3.

:- end_tests(jouar).

/*
Harry es sangre mestiza, y se caracteriza por ser corajudo, amistoso, orgulloso e inteligente. Odiaría que 
el sombrero lo mande a Slytherin.
Draco es sangre pura, y se caracteriza por ser inteligente y orgulloso, pero no es corajudo ni amistoso. Odiaría que 
el sombrero lo mande a Hufflepuff.
Hermione es sangre impura, y se caracteriza por ser inteligente, orgullosa y responsable. No hay ninguna 
casa a la que odiaría ir.
*/

% mago(Nombre,Sangre,Caracteristicas(Caracteristica),Odia)


% mago(Quien).
mago(harry).
mago(draco).
mago(hermione).
mago(ron).
mago(luna).

% sangre(Quien,Tipo).
sangre(harry,mestiza).
sangre(graco,pura).
sangre(hermione,impura).

% caracteristicas(Quien,caracteristica).
caracteristica(harry,coraje). 
caracteristica(harry,amistoso).
caracteristica(harry,orgullo).
caracteristica(harry,inteligencia).
caracteristica(draco,inteligencia).
caracteristica(draco,orgullo).
caracteristica(hermione,inteligencia).
caracteristica(hermione,orgullo).
caracteristica(hermione,responsabilidad).

% odia(Quien,Casa).
odia(harry,slytherin).
odia(draco,hufflepuff).


/*
Para Gryffindor, lo más importante es tener coraje.
Para Slytherin, lo más importante es el orgullo y la inteligencia.
Para Ravenclaw, lo más importante es la inteligencia y la responsabilidad.
Para Hufflepuff, lo más importante es ser amistoso. 
*/

%paraEntrarEn(Casa,Cualidad).
paraEntrarEn(griffindor,coraje).
paraEntrarEn(slytherin,orgullo).
paraEntrarEn(slytherin,inteligencia).
paraEntrarEn(ravenclaw,inteligencia).
paraEntrarEn(hufflepuff,amistoso).

casa(griffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).
/*
Saber si una casa permite entrar a un mago, lo cual se cumple para cualquier mago y cualquier casa excepto en el caso 
de Slytherin, que no permite entrar a magos de sangre impura.
Saber si un mago tiene el carácter apropiado para una casa, lo cual se cumple para cualquier mago si sus características 
incluyen todo lo que se busca para los integrantes de esa casa, independientemente de si la casa le permite la entrada.
Determinar en qué casa podría quedar seleccionado un mago sabiendo que tiene que tener el carácter adecuado para la casa, 
la casa permite su entrada y además el mago no odiaría que lo manden a esa casa. Además Hermione puede quedar seleccionada en Gryffindor, 
porque al parecer encontró una forma de hackear al sombrero.
Definir un predicado cadenaDeAmistades/1 que se cumple para una lista de magos si todos ellos se caracterizan por ser 
amistosos y cada uno podría estar en la misma casa que el siguiente. No hace falta que sea inversible, se consultará de 
forma individual.
*/

puedeEntrar(Mago,Casa):- laCasaLoAcepta(Mago,Casa).

laCasaLoAcepta(_,griffindor).
laCasaLoAcepta(_,hufflepuff).
laCasaLoAcepta(_,ravenclaw).
laCasaLoAcepta(Mago,slytherin):- not(sangre(Mago,impura)).

tieneCaracter(Mago,Casa):- forall(paraEntrarEn(Casa,Caracteristica),caracteristica(Mago,Caracteristica)).

puedeQuedarEn(hermione,griffindor).
puedeQuedarEn(Mago,Casa):- 
  distinct(casa(Casa)),
  tieneCaracter(Mago,Casa), 
  laCasaLoAcepta(Mago,Casa),
  not(odia(Mago,Casa)).

cadenaDeAmistades(Magos):- sonAmistosos(Magos), cadenaCasas(Magos).

sonAmistosos(Magos):- forall(member(Mago,Magos),amistoso(Mago)).
amistoso(Mago):- caracteristica(Mago,amistoso).

cadenaCasas([_]).
cadenaCasas([Mago1, Mago2 | MagosSiguientes]):- 
  puedeQuedarEn(Mago1,Casa),
  puedeQuedarEn(Mago2,Casa), 
  cadenaCasas([Mago2 | MagosSiguientes]).

/*
Harry anduvo fuera de cama.
Hermione fue al tercer piso y a la sección restringida de la biblioteca.
Harry fue al bosque y al tercer piso.
Draco fue a las mazmorras.
A Ron le dieron 50 puntos por su buena acción de ganar una partida de ajedrez mágico.
A Hermione le dieron 50 puntos por usar su intelecto para salvar a sus amigos de una muerte horrible.
A Harry le dieron 60 puntos por ganarle a Voldemort.

También sabemos que los siguientes lugares están prohibidos:

El bosque, que resta 50 puntos.
La sección restringida de la biblioteca, que resta 10 puntos.
El tercer piso, que resta 75 puntos.
*/

accion(ron, "ganar una partida de ajedrez magico", 500).
accion(hermione, "salvar a sus amigos", 50).
accion(harry, "vencer a voldemort", 60).
accion(draco, "ir a las masmorras", 150).
accion(harry, "andar de noche fuera de la cama", -50).
accion(harry,"ir al tercer piso", -75).
accion(harry,"ir al bosque", -50).
accion(hermione, "ir al tercer piso", -75).
accion(hermione, "ir a la seccion prohibida de la biblioteca", -10).

malaAccion("andar de noche fuera de la cama").
malaAccion("ir al tercer piso").
malaAccion("ir al bosque").
malaAccion("ir a la seccion prohibida de la biblioteca").

esDe(hermione, griffindor).
esDe(ron, griffindor).
esDe(harry, griffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

buenAlumno(Mago):- 
  accion(Mago,_,_),
  forall(accion(Mago,Accion,_), not(malaAccion(Accion))).

accionRecurrente(Accion):-
  mago(Mago1),
  mago(Mago2),
  Mago1 \= Mago2,
  accion(Mago1,Accion,_),
  accion(Mago2,Accion,_).

puntajeTotal(Casa,PuntajeTotalCasa):- 
  casa(Casa),
  findall(Puntaje,(esDe(Mago,Casa),accion(Mago,_,Puntaje)),PuntajeTotal),
  sumlist(PuntajeTotal,PuntajeTotalCasa).

casaGanadora(Casa):-
  puntajeTotal(Casa,PuntajeCasa),
  forall((puntajeTotal(OtraCasa,PuntajeOtraCasa),Casa\=OtraCasa), PuntajeCasa>PuntajeOtraCasa).



  



