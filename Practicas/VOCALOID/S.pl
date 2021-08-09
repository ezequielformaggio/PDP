cantante(megurineLuka).
cantante(hatsuneMiku).
cantante(gumi).
cantante(seeU).
cantante(kaito).

canta(megurineLuka,nightFever,4).
canta(megurineLuka,foreverYoung,5).
canta(hatsuneMiku,tellYourWorld,4).
canta(gumi,foreverYoung,4).
canta(gumi,tellYourWorld,5).
canta(seeU,novemberRain,6).
canta(seeU,nightFever,5).

/*
Para comenzar el concierto, es preferible introducir primero a los cantantes más novedosos, por lo que necesitamos 
un predicado para saber si un vocaloid es novedoso cuando saben al menos 2 canciones y el tiempo total que duran todas 
las canciones debería ser menor a 15.
*/

novedoso(Cantante):- 
    cuantasCancionesSabe(Cantante,CantidadDeCanciones), 
    duracionTotalCanciones(Cantante,MinutosTotales),
    MinutosTotales < 15,
    CantidadDeCanciones >= 2.

cuantasCancionesSabe(Cantante,CantidadDeCanciones):-
    cantante(Cantante),
    findall(Cancion,canta(Cantante,Cancion,_),Canciones),
    length(Canciones, CantidadDeCanciones).

duracionTotalCanciones(Cantante,MinutosTotales):-
    cantante(Cantante),
    findall(Minutos,canta(Cantante,_,Minutos),ListaMinutos),
    sumlist(ListaMinutos,MinutosTotales).

/*
Hay algunos vocaloids que simplemente no quieren cantar canciones largas porque no les gusta, es por eso que 
se pide saber si un cantante es acelerado, condición que se da cuando todas sus canciones duran 4 minutos o menos. 
Resolver sin usar forall/2.
*/

esAcelerado(Cantante):- 
    cantante(Cantante),
    findall(Minutos,canta(Cantante,_,Minutos),ListaMinutos),
    duranMenosDe4(ListaMinutos).

duranMenosDe4([MinutosCancion]):-
    MinutosCancion =< 4.

duranMenosDe4([MinutosCancion|Minutos]):-
    MinutosCancion =< 4,
    duranMenosDe4(Minutos).

concierto(mikuExpo,"estados unidos",2000).
concierto(magicalMirai,"japon",3000).
concierto(vocalektVisions,"estados unidos",1000).
concierto(mikuFest,"argentina",100).


puedeParticipar(Cantante,Concierto):- cumpleCondiciones(Cantante,Concierto).

cumpleCondiciones(Cantante,mikuExpo):- 
    cantante(Cantante),
    cuantasCancionesSabe(Cantante,CantidadDeCanciones),
    duracionTotalCanciones(Cantante,MinutosTotales),
    CantidadDeCanciones > 2,
    MinutosTotales >= 6.

cumpleCondiciones(Cantante,magicalMirai):- 
    cantante(Cantante),
    cuantasCancionesSabe(Cantante,CantidadDeCanciones),
    duracionTotalCanciones(Cantante,MinutosTotales),
    CantidadDeCanciones > 3,
    MinutosTotales >= 10.

cumpleCondiciones(Cantante,magicalMirai):- 
    cantante(Cantante),
    cuantasCancionesSabe(Cantante,CantidadDeCanciones),
    CantidadDeCanciones >= 1,
    duracionTotalCanciones(Cantante,MinutosTotales),
    MinutosTotales =< 9.

cumpleCondiciones(Cantante,mikuFest):- 
    cantante(Cantante),
    cuantasCancionesSabe(Cantante,CantidadDeCanciones),
    not(esAcelerado(Cantante)),
    CantidadDeCanciones >= 1.

cumpleCondiciones(hatsuneMiku,_).

masFamoso(Cantante):- 
    cuantaFamaTiene(Cantante,CantidadDeFamaCantante),
    forall((cuantaFamaTiene(OtroCantante,CantidadDeFamaOtroCantante), Cantante \= OtroCantante), 
    CantidadDeFamaCantante > CantidadDeFamaOtroCantante).

cuantaFamaTiene(Cantante,FamaTotal):-
    cantante(Cantante),
    famaConciertos(Cantante, FamaConciertos),
    cuantasCancionesSabe(Cantante,CantidadDeCanciones),
    FamaTotal is FamaConciertos * CantidadDeCanciones.

famaConciertos(Cantante, FamaConciertos):- 
    cantante(Cantante),
    findall(Fama,(puedeParticipar(Cantante,Concierto),concierto(Concierto,_,Fama)),ListaFama),
    sumlist(ListaFama,FamaConciertos).

conoce(megurineLuka,hatsuneMiku).
conoce(megurineLuka,gumi).
conoce(gumi,seeU).
conoce(seeU,kaito).

/*
Queremos verificar si un vocaloid es el único que participa de un concierto, esto se cumple si 
ninguno de sus conocidos ya sea directo o indirectos (en cualquiera de los niveles) participa 
en el mismo concierto.
*/

unicoParticipante(Cantante,Concierto):-
    sonConocidos(Cantante,Conocido),
    puedeParticipar(Cantante,Concierto),
    puedeParticipar(Conocido,Concierto).

sonConocidos(Canante,Conocido):-
    conoce(Cantante,Conocido).
sonConocidos(Cantante,Conocido):-
    conoce(Cantante,UnConocido),
    conoce(UnConocido,Conocido).

/*
Supongamos que aparece un nuevo tipo de concierto y necesitamos tenerlo en cuenta en nuestra 
solución, explique los cambios que habría que realizar para que siga todo funcionando. 
¿Qué conceptos facilitaron dicha implementación?
*/