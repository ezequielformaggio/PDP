:- begin_tests(cafeVeloz).

  test(fakeTest):-
    A is 1 + 2,
    A =:= 3.

:- end_tests(cafeVeloz).

% jugadores conocidos
jugador(maradona).
jugador(chamot).
jugador(balbo).
jugador(caniggia).
jugador(passarella).
jugador(pedemonti).
jugador(basualdo).

% amigos
amigo(maradona, caniggia).
amigo(caniggia, balbo).
amigo(balbo, chamot).
amigo(balbo, pedemonti).

/*
%para Ingerir
%sustancias
sustancia(efedrina).
sustancia(cocaina).
%compuesto
compuesto(cafeVeloz).
%productos
producto(cocacola,_).
producto(gatoreit,_).
producto(naranju,_).
*/

% relaciona lo que toma cada jugador
tomo(maradona, sustancia(efedrina)).
tomo(maradona, compuesto(cafeVeloz)).
tomo(caniggia, producto(cocacola, 2)).
tomo(chamot, compuesto(cafeVeloz)).
tomo(balbo, producto(gatoreit, 2)).

% relaciona la máxima cantidad de un producto que 1 jugador puede ingerir
maximo(cocacola, 3). maximo(gatoreit, 1).
maximo(naranju, 5).

% relaciona las sustancias que tiene un compuesto
composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).

% sustancias prohibidas por la asociación
sustanciaProhibida(efedrina). 
sustanciaProhibida(cocaina).


%Se pide:
%1) Hacer lo que sea necesario para incorporar los siguientes conocimientos:
%a. passarella toma todo lo que no tome Maradona
%b. pedemonti toma todo lo que toma chamot y lo que toma Maradona
%c. basualdo no toma coca cola

%2) Definir el predicado puedeSerSuspendido/1 que relaciona si un jugador puede ser
%suspendido en base a lo que tomó. El predicado debe ser inversible.

%a. un jugador puede ser suspendido si tomó una sustancia que está prohibida
%b. un jugador puede ser suspendido si tomó un compuesto que tiene una sustancia prohibida
%c. o un jugador puede ser suspendido si tomó una cantidad excesiva de un producto (más que el máximo permitido):

puedeSerSuspendido(Jugador):- tomo(Jugador,sustancia(Sustancia)), sustanciaProhibida(Sustancia).

puedeSerSuspendido(Jugador):- tomo(Jugador,compuesto(Compuesto)), 
                              compuestoTieneSustanciaProhibida(Compuesto,_).
                                       
puedeSerSuspendido(Jugador):- tomo(Jugador,producto(Producto,Cantidad)), 
                              maximo(Producto,Maximo),
                              Cantidad > Maximo.

compuestoTieneSustanciaProhibida(Compuesto,Sustancia):- composicion(Compuesto,Sustancias), 
                                                        sustanciaProhibida(Sustancia),                                                           
                                                        member(Sustancia, Sustancias).
                                                         

% Defina el predicado malaInfluencia/2 que relaciona dos jugadores, si ambos pueden ser
% suspendidos y además se conocen. Un jugador conoce a sus amigos y a los conocidos de sus
% amigos.

malaInfluencia(UnJugador,OtroJugador):- distinct(puedeSerSuspendido(UnJugador)),
                                        distinct(puedeSerSuspendido(OtroJugador)),
                                        seConocen(UnJugador,OtroJugador).

seConocen(UnJugador,OtroJugador):- amigo(UnJugador,OtroJugador).
seConocen(UnJugador,OtroJugador):- amigo(UnJugador,JugadorRandom), seConocen(JugadorRandom,OtroJugador).

% atiende(medico, jugador).
atiende(cahe, maradona).
atiende(cahe, chamot).
atiende(cahe, balbo).
atiende(zin, caniggia).
atiende(cureta, pedemonti).
atiende(cureta, basualdo).

% Definir el predicado chanta/1, que se verifica para los médicos que sólo atienden a jugadores que
% podrían ser suspendidos. El predicado debe ser inversible.

medico(Medico):- atiende(Medico,_).
chanta(Medico):- distinct(medico(Medico)), forall(atiende(Medico,Jugador), puedeSerSuspendido(Jugador)).

% nivel de sustancia en sangre
nivelFalopez(efedrina, 10).
nivelFalopez(cocaina, 100).
nivelFalopez(extasis, 120).
nivelFalopez(omeprazol, 5).



/*
Definir el predicado cuantaFalopaTiene/2, que relaciona el nivel de alteración en sangre que tiene
un jugador, considerando que:
- todos los productos (como la coca cola y el gatoreit), no tienen nivel de alteración (asumir 0)
- las sustancias tienen definidas el nivel de alteración en base al predicado nivelFalopez/2
- los compuestos suman los niveles de falopez de cada sustancia que tienen.
El predicado debe ser inversible en ambos argumentos. 
Ej: el cafeVeloz tiene nivel 130 (120 del éxtasis + 10 de la efedrina, las sustancias que no tienen nivel se asumen 0).
*/

%cuantaFalopaTiene(Jugador,Cantidad):- 

/*
6) Definir el predicado medicoConProblemas/1, que se satisface si un médico atiende a más de 3
jugadores conflictivos, esto es
- que pueden ser suspendidos o
- que conocen a Maradona (según el punto 3, donde son amigos directos o conocen a
alguien que es amigo de él). El predicado debe ser inversible.
*/

medicoConProblemas(Medico):- medico(Medico),
                             findall(Jugador,atiende(Medico,Jugador),Jugadores),
                             length(Jugadores, Cantidad),
                             Cantidad >= 3.

jugadoresConflictivos(Jugador):- distinct(puedeSerSuspendido(Jugador)).
jugadoresConflictivos(Jugador):- seConocen(maradona,Jugador).