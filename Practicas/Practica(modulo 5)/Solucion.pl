/*tiene(juan, foto([juan, hugo, pedro, lorena, laura], 1988 )).
tiene(juan, foto([juan], 1977 )).
tiene(juan, libro(saramago, "Ensayo sobre la ceguera")).
tiene(juan, bebida(whisky)).
tiene(valeria, libro(borges, "Ficciones")).
tiene(lucas, bebida(cusenier)).
tiene(pedro, foto([juan, hugo, pedro, lorena, laura], 1988 )).
tiene(pedro, foto([pedro], 2010 )).
tiene(pedro, libro(octavioPaz, "Salamandra")).

premioNobel(octavioPaz).
premioNobel(saramago).

persona(Persona):- tiene(Persona,_).


Determinamos que alguien es coleccionista si todos los elementos que tiene son
valiosos:
● un libro de un premio Nobel es valioso
● una foto con más de 3 integrantes es valiosa
● una foto anterior a 1990 es valiosa
● el whisky es valioso


coleccionista(Persona):- distinct(persona(Persona)), forall(tiene(Persona,Objeto),valioso(Objeto)).

valioso(libro(Autor,_)):- premioNobel(Autor).
valioso(foto(Integrantes,_)):- length(Integrantes, Cantidad), Cantidad > 3.
valioso(foto(_,Anio)):- Anio < 1990.
valioso(bebida(whisky)).



actividad(cine ).
actividad(arjona ).
actividad(princesas_on_ice ).
actividad(pool ).
actividad(bowling ).

costo(cine , 400 ).
costo(arjona , 1750 ).
costo(princesas_on_ice , 2500 ).
costo(pool , 350 ).
costo(bowling , 300 ).

actividades(Plata,ActividadesPosibles):-
    findall(Actividad,actividad(Actividad),Actividades),
    actividadesPosibles(Actividades,Plata,ActividadesPosibles).

actividadesPosibles([],_,[]).

actividadesPosibles([Actividad|Actividades],Plata,[Actividad|ActividadesPosibles]):-
    costo(Actividad,Costo),
    Plata > Costo,
    PlataActual is Plata - Costo,
    actividadesPosibles(Actividades,PlataActual,ActividadesPosibles).

actividadesPosibles([_|Actividades],Plata,ActividadesPosibles):- actividadesPosibles(Actividades,Plata,ActividadesPosibles).
*/
cocinero(donato).
cocinero(pietro).
pirata(felipe,27).
pirata(marcos,39).
pirata(facundo,45).
pirata(tomas,20).
pirata(betina,26).
pirata(gonzalo,22).
bravo(tomas).
bravo(felipe).
bravo(marcos).
bravo(betina).
personasPosibles([donato , pietro , felipe , marcos , facundo , tomas , gonzalo , betina]).

/*
Un pirata quiere armar la tripulación para su barco, él solo quiere llevar
● cocineros
● piratas bravos
● piratas de más de 40 años (no pagan impuestos)
*/
tripulacionBarco(Tripulacion):-
    personasPosibles(Personas), %personas es lista
    tripulacion(Personas,Tripulacion). 

tripulacion([],[]).
/*
tripulacion([Persona|Personas],[Persona|Tripulacion]):-
    cumpleRequisitos(Persona),
    tripulacion(Personas,Tripulacion).
tripulacion([_|Personas],Tripulacion):-
    tripulacion(Personas,Tripulacion).
*/

tripulacion([Persona|Personas],[Persona|Tripulacion]):-
    cumpleRequisitos(Persona),
    tripulacion(Personas,Tripulacion).
tripulacion([_|Personas],Tripulacion):-
    tripulacion(Personas,Tripulacion).

cumpleRequisitos(Pasajero):- pirata(Pasajero,_), bravo(Pasajero).
cumpleRequisitos(Pasajero):- cocinero(Pasajero).
cumpleRequisitos(Pasajero):- pirata(Pasajero,Edad), Edad > 40.

