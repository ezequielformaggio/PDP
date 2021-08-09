:- begin_tests(mafia).

  test(fakeTest):-
    A is 1 + 2,
    A =:= 3.

  test(punto1_pierdeNick1, nondet):-
    perdio(nick,1).
  test(punto1_pierdeHomero4):-
    perdio(homero,4).
  test(punto1_pierdeLisa1,fail):-
    perdio(lisa,1).
  test(punto1_pierdeRafa2,nondet):-
    perdio(rafa,2).
  test(punto1_pierdeMaggie_,fail):-
    perdio(maggie,_).
  test(punto1_pierdeBart5,nondet):-
    perdio(bart,5).
  test(punto1_pierdeLisa5):-
    perdio(lisa,5).
  
  test(punto2a_contrincantesDeTony,
    set(Contrincantes == [homero, burns, nick, hibbert, lisa, rafa])):-
    contrincantes(tony,Contrincantes).

  test(punto2a_contrincantesDeHomero,
    set(Contrincantes == [bart, tony, maggie])):-
    contrincantes(homero,Contrincantes).

    test(punto2a_ganoMaggie):-
      ganadores(maggie).

    test(punto3b_imbatibleHibbert, fail):-
      medicoEsImbatible(hibbert).

    test(punto3b_imbatibleNick, fail):-
      medicoEsImbatible(nick).

    test(punto3b_imbatibleLisa,nondet):-
      detectiveEsImbatible(lisa).

    test(punto3b_imbatibleRafa, fail):-
      detectiveEsImbatible(rafa).

    test(punto3b_imbatibleHomero, fail):-
      detectiveEsImbatible(homero).

    test(punto4a_sigueJugandoRafa2):-
      sigueEnJuego(rafa,2).

    test(punto4a_sigueJugandoNick4,fail):-
      sigueEnJuego(nick,4).

    test(punto4a_sigueJugandoMaggie6):-
      sigueEnJuego(maggie,6).

    test(punto4a_sigueJugandoBurns6):-
      sigueEnJuego(burns,6).

    test(punto4a_sigueJugandoTodos1,
      set(Quienes == [homero, burns, bart, tony, maggie, nick, hibbert,lisa, rafa])):-
      sigueEnJuego(Quienes,1).

    test(punto4b_rondaInteresante1,nondet):-
      esinteresante(1).

    test(punto4b_rondaInteresante6,nondet):-
      esinteresante(6).

    test(punto4b_rondaInteresante3, fail, nondet):-
      esinteresante(3).

    test(punto4b_rondaInteresanteCuales,
      set(Cuales == [1,2,6])):-
      distinct(esinteresante(Cuales)).

:- end_tests(mafia).

%casos de prueba para agregar 
/*
• nick pierde en la primera ronda porque es eliminado (no importa que se quiera salvar, eso solo   sirve cuando te ataca la mafia).
• homero pierde en la cuarta ronda porque es atacado por la mafia.
• lisa no pierde en la primer ronda porque es salvada.
• rafa pierde en la segunda ronda porque es eliminado, por más que lo hayan salvado.
• maggie no perdió en ninguna ronda.
• En la quinta ronda pierden bart y lisa.
*/


% base de conocimientos

% rol(Persona, Rol).
rol(homero, civil).
rol(burns, civil).
rol(bart, mafia).
rol(tony, mafia).
rol(maggie, mafia).
rol(nick, medico).
rol(hibbert, medico).
rol(lisa, detective).
rol(rafa, detective).

/*
1.	Modelar las acciones anteriores de forma tal que se pueda:
  a.	Expandir la base de conocimiento agregando información de las acciones que se produjeron en cada ronda. 
      Incorporar la siguiente partida finalizada:
*/

%atacarA(Persona,Ronda).
atacarA(lisa,1).
atacarA(rafa,2).
atacarA(lisa,3).
atacarA(homero,4).
atacarA(lisa,5).
atacarA(burns,6).
%salvarA(Persona, Doctor, Ronda).
salvarA(nick,nick, 1).
salvarA(lisa,hibbert,1 ).
salvarA(rafa,hibbert, 2).
salvarA(lisa,hibbert,3).
%investigarA(Persona, Detective, Ronda).
investigarA(tony,lisa,1).
investigarA(lisa,rafa,1).
investigarA(bart,lisa,2).
investigarA(maggie,rafa,2).
investigarA(burns,lisa,3).
investigarA(homero,lisa,4).
investigarA(maggie,lisa,5).
%eliminarA(Persona, Ronda).
eliminarA(nick,1).
eliminarA(rafa,2).
eliminarA(hibbert,3).
eliminarA(tony,4).
eliminarA(bart,5).


jugador(Jugador):- rol(Jugador,_).


/*
  b.	Deducir las personas que perdieron en una determinada ronda. O sea, aquellas que fueron 
  -	eliminadas en dicha ronda, o
  -	atacadas por la mafia, salvo que algún médico haya salvado a la persona, en dicha ronda.
*/

perdio(Jugador,Ronda):- jugador(Jugador) ,eliminarA(Jugador,Ronda).
perdio(Jugador,Ronda):- jugador(Jugador) ,atacarA(Jugador,Ronda), not(salvarA(Jugador,_,Ronda)).
% Explicar qué conceptos permiten resolver este requerimiento sin la necesidad de armar listas.

/*Este requerimiento es posible de resolver sin armar listas ya que a diferencia de funcional, donde la informacion podria estar
  guardada en una variable que contenga una lista, en logico contamos con una base de conocimientos, donde declaramos hechos, los cuales
  el motor de prolog puede relacionar entre si sin necesidad de tenerlos agrupados en listas.
*/

% INTEGRANTE 1 - GANADOR
/*
Algo que a todo el mundo le interesa es saber si ya hay un ganador, y en el caso que lo haya saber quién es. 
Nos contaron que existen dos bandos en el juego:
-	Por un lado, los integrantes de la mafia.
-	Y por el otro, el resto de los jugadores.
El juego termina cuando un bando logra sacar por completo al otro del juego.
*/

% bando(Jugador,pueblo):- rol(Jugador,_), not(rol(Jugador,mafia)). -> Era redundante
bando(Jugador,mafioso):- rol(Jugador,mafia).

/*
2.	Necesitamos
  a.	Conocer los contrincantes de una persona, o sea, los del otro bando. 
      Si la persona pertenece a la mafia, los contrincantes son todos aquellos que no forman parte de la mafia; y viceversa. 
      Esta relación debe ser simétrica .
*/

contrincantes(Jugador1,Jugador2):- jugador(Jugador1), jugador(Jugador2), bando(Jugador1,Bando), not(bando(Jugador2,Bando)).

/*
Saber si alguien ganó, y en el caso que haya ganadores, conocerlos todos. 
Una persona es ganadora cuando no perdió pero todos sus contrincantes sí. 
*/

%Explicar cómo se relaciona el concepto de inversibilidad con la solución.
%Es posible conocer a todos los contrincantes ya que, al preguntarle quienes no son del mismo bando, prolog relaciona a todo el
%resto de jugadores (que estan definidos en la base de conocimiento). Si no estuviesen definidos, no tendriamos el universo con el cual
%comparar las posibles soluciones.

ganadores(Jugador):- nuncaPerdio(Jugador), perdieronSusContrincantes(Jugador).

nuncaPerdio(Jugador):- jugador(Jugador), not(perdio(Jugador,_)).
perdieronSusContrincantes(Jugador):- forall(contrincantes(Jugador,Contrincantes), perdio(Contrincantes,_)).


%   INTEGRANTE 2 - IMBATIBLE
/*
La mafia se enteró de nuestro sistema y nos pidió información sobre algunos jugadores que 
considera imbatibles para poder planear mejor sus ataques. Nos contaron que:
-	Un médico es imbatible cuando salvó a todos los que estaban siendo atacados por la mafia.
-	Un detective es imbatible cuando investiga a todas las personas que pertenecen a la mafia.
-	El resto de las personas nunca son imbatibles.
*/

medicoEsImbatible(Medico) :- rol(Medico, medico),forall(atacarA(Jugador,_), salvarA(Jugador, Medico,_)).
detectiveEsImbatible(Detective) :- rol(Detective, detective), forall(rol(Jugador, mafia), investigarA(Jugador, Detective,_)).

esImbatible(Jugador) :- medicoEsImbatible(Jugador).
esImbatible(Jugador) :- detectiveEsImbatible(Jugador).

% El predicado esImbatible inversible porque podemos hacer consultas existenciales y tenemos definido el Universo Cerrado
% porque no es necesario definir lo que no cumplen.


%   MAS INFO - (DIVIDIDO)
/*
4.	Implementar los predicados necesarios para
  a.	(integrante 1) Deducir las personas que siguen en juego en una determinada ronda, o sea, las que todavía no perdieron 
      (sin importar si pierde en dicha ronda o posterior).
*/

sigueEnJuego(Jugador,Ronda):- jugador(Jugador), forall(rondasAnteriores(Ronda,RondasAteriores), not(perdio(Jugador, RondasAteriores))).

rondasAnteriores(Ronda,RondasAteriores):- rondaAnterior(Ronda,RondaAnterior), between(1,RondaAnterior,RondasAteriores).
rondaAnterior(Ronda,RondaAnterior):- RondaAnterior is Ronda -1.
% hacer casos de prueba

/*
b.	(integrante 2) Conocer cuáles son las rondas interesantes que tuvo la partida. 
    Una ronda es interesante si en dicha ronda siguen más de 7 personas en juego;
    o bien quedan en juego menos o igual cantidad de personas que la cantidad inicial de la mafia..
*/

esinteresante(Ronda) :- 
  cantJugadoresPorRonda(Ronda, Cantidad),
  Cantidad > 7.

esinteresante(Ronda) :-
  findall(Mafioso, rol(Mafioso,mafia), Mafiosos),
  length(Mafiosos, CantidadMafiosos),
  cantJugadoresPorRonda(Ronda, Cantidad),
  Cantidad =< CantidadMafiosos.

cantJugadoresPorRonda(Ronda, Cantidad) :-
  accion(_,_,Ronda),
  findall(Jugador, sigueEnJuego(Jugador,Ronda), Jugadores), 
  length(Jugadores, Cantidad).

esContrincante(Jugador1, Jugador2) :- rol(Jugador1, mafia), not(rol(Jugador2, mafia)), Jugador1 \= Jugador2.
esContrincante(Jugador1, Jugador2) :- rol(Jugador2, mafia), not(rol(Jugador1, mafia)), Jugador1 \= Jugador2.

%   ESTRATEGIA - (DIVIDIDO)

/*
A partir de que nuestro sistema se popularizó entre la comunidad, las estrategias llevadas a cabo por las personas que juegan 
activamente son cada vez más complejas. Nos pidieron ayuda para identificar a estos jugadores y sus estrategias.

Para lograr esto, algo que deberá saber son las personas responsables y afectadas de una determinada acción:
-	Atacar una persona: las personas responsables son todas las que conforman la mafia. La persona afectada es la atacada.
-	Salvar una persona: la persona responsable es el médico, la afectada es la persona salvada.
-	Investigar a una persona: la persona responsable es el detective que investiga, la afectada es la persona investigada.
-	Eliminar a una persona: las personas responsables son todos los contrincantes (punto 2.a) de la persona eliminada. 
  La persona afectada es la eliminada.
*/

accion(Afectado,Responsable,Ronda):- atacarA(Afectado,Ronda), bando(Responsable,mafioso).
accion(Afectado,Responsable,Ronda):- rol(Responsable,medico),salvarA(Afectado,Responsable,Ronda).
accion(Afectado,Responsable,Ronda):- rol(Responsable,detective),investigarA(Afectado,Responsable,Ronda).
accion(Afectado,Responsable,Ronda):- eliminarA(Afectado,Ronda),contrincantes(Afectado,Responsable).

/*
  a.	Conocer los jugadores profesionales, que son aquellos que le hicieron algo a todos sus contrincantes, o sea que las 
      acciones de las que el profesional es responsable terminaron afectando a todos sus contrincantes.
*/

profesional(Jugador):- jugador(Jugador), forall(contrincantes(Jugador,Contrincantes),accion(Contrincantes,Jugador,_)).

/*
b.	Encontrar una estrategia que se haya desenvuelto en la partida. Una estrategia es una serie de acciones que se desarrollan 
    a lo largo de la partida y deben cumplir que:
    -	Las acciones sucedieron en orden durante la partida.
    -	Hay solamente una acción por ronda: la primera acción corresponde a la primera ronda, la segunda acción corresponde a la segunda ronda, 
      y así sucesivamente hasta la última ronda (respetando tantas acciones como cantidad de rondas haya, 
      no puede haber 5 acciones si son 6 rondas).
    -	Las acciones están encadenadas, lo que significa que la persona afectada por la acción anterior es la responsable de la siguiente.
*/
estrategia(CantidadRondas,[accion(Afectado,_,Ronda),accion(_,Afectado,RondaSiguiente)]):-
  RondaSiguiente is Ronda + 1,
  CantidadRondas == RondaSiguiente.
estrategia(CantidadRondas,[accion(Afectado,_,Ronda),accion(_,Afectado,RondaSiguiente)|ListaAciones]) :-
  RondaSiguiente is Ronda + 1,
  estrategia(CantidadRondas, [accion(_,Afectado,RondaSiguiente)|ListaAciones]).

/*
estrategia(6,[atacarA(lisa,1),investigarA(bart,lisa, 2),atacarA(lisa,3),investigarA(homero,lisa,4),eliminarA(bart,5),atacarA(burns,6)]).
estrategia(6,[accion(lisa,tony,1),accion(bart,lisa,2),accion(lisa,bart,3),accion(homero,lisa,4),accion(bart,homero,5),accion(burns,bart,6)]).
acciones(2,[atacarA(rafa,2),
            salvarA(rafa,hibbert, 2),
            investigarA(bart,lisa,2),
            investigarA(maggie,rafa,2),
            eliminarA(rafa,2)]).

acciones(3,[atacarA(lisa,3),
            salvarA(lisa,hibbert,3),
            investigarA(burns,lisa,3),
            eliminarA(hibbert,3)]).

acciones(4,[atacarA(homero,4),
            investigarA(homero,lisa,4),
            eliminarA(tony,4)]).

acciones(5,[atacarA(lisa,5),
            investigarA(maggie,lisa,5),
            eliminarA(bart,5)]).

acciones(6,[atacarA(burns,6)]).

partidaActual([atacarA(lisa,1),
               salvarA(nick,nick, 1),        
               salvarA(lisa,hibbert,1), 
               investigarA(tony,lisa,1), 
               investigarA(lisa,rafa,1), 
               eliminarA(nick,1),atacarA(rafa,2),
               salvarA(rafa,hibbert, 2),
               investigarA(bart,lisa,2),
               investigarA(maggie,rafa,2),
               eliminarA(rafa,2),
               atacarA(lisa,3),
               salvarA(lisa,hibbert,3),
               investigarA(burns,lisa,3),
               eliminarA(hibbert,3),
               atacarA(homero,4),
               investigarA(homero,lisa,4),
               eliminarA(tony,4),
               atacarA(lisa,5),
               investigarA(maggie,lisa,5),
               eliminarA(bart,5),
               atacarA(burns,6)]).

partidaFicticia([atacarA(burns,6)]).
*/ 

%partidaActual([Acciones])

%estrategia(Partida):- accionesEnOrden(Partida).
%estrategia(Partida):- accionesEncadenadas(Partida).
%estrategia(Partida):- unaAccionPorRonda(Partida).

% estrategia(acciones(Ronda,Acciones)):-accionesEnOrden(Ronda,Acciones)

%accionesEnOrden(Partida):- acciones(_,Acciones).
%recursividad


%primerAccion(Lista):- head([Lista | Acciones], Accion).
%segundaAccion(Acciones):- head([Acciones | _], Acciones).
%Accion is Acciones.

%accionesEncadenadas(Afectado,Responsable,Ronda):- accion(Afectado,Responsable,Ronda).
%accionesEncadenadas(VictimaAfectado,Afectado,RondaSiguiente),
%RondaSiguiente is Ronda + 1.


