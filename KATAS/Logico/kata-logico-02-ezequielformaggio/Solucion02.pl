
:- begin_tests(delivery).

  test(fakeTest):-
    A is 1 + 2,
    A =:= 3.

  test(dodain_puede_repartir_cosas_de_supermercado, nondet):-
    disponible(dodain,supermercado).

  test(los_pedidos_que_puede_tomar_zolotar, 
    set(Pedidos == [sushi, libreria])):-
      disponible(zolotar,Pedidos).

  test(juan_puede_repartir_sushi, fail) :-
    disponible(juan,sushi).  

:- end_tests(delivery).

% cadete(Nombre, trabaja(Dias que tabaja, Zonas donde trabaja))
cadete(zolotar, trabaja([lunes, jueves, sabado],[wilde, berazategui, quilmes])).
cadete(juan, trabaja([lunes,viernes],[caba])).
cadete(dodain, trabaja([miercoles,sabado, domingo],[quilmes, caba])).

% pedido(mercaderia, dia, direccion)
pedido(supermercado, sabado, caba).
pedido(sushi, lunes, wilde).
pedido(libreria, lunes, quilmes).

%Qué cadetes podrían repartir cada pedido, considerando restricciones de lugar y día.

disponible(Cadete, Pedido):- coincidezona(Cadete,Pedido), coincidedia(Cadete,Pedido).

coincidezona(Cadete,Pedido):- zonascadete(Cadete,ZonasCadete), zonapedido(Pedido,ZonaPedido), member(ZonaPedido,ZonasCadete).
zonascadete(Cadete,ZonasCadete):- cadete(Cadete,trabaja(_,ZonasCadete)).
zonapedido(Pedido,ZonaPedido):- pedido(Pedido,_,ZonaPedido).

coincidedia(Cadete, Pedido):- diascadete(Cadete,DiasCadete), diapedido(Pedido,DiaPedido), member(DiaPedido,DiasCadete).
diascadete(Cadete,DiasCadete):- cadete(Cadete,trabaja(DiasCadete,_)).
diapedido(Pedido,DiaPedido):- pedido(Pedido,DiaPedido,_).

%El testeo unitario es opcional, debe quedar claro cómo resuelve los requerimientos pedidos (qué consultas se hacen).
