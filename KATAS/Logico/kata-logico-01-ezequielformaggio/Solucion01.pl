
:- begin_tests(parrilla).

  test(fakeTest):-
    A is 1 + 2,
    A =:= 3.

      test(cuales_son_los_platos_caros_de_la_parrilla, set(Platos == [chinchulines,mollejas])) :-
          menuCaro(Platos).

      test(cuales_son_los_gustos_de_jocelyn, 
        set(Platos == [mollejas,papaalplomo,provoleta])) :-
          gustos(jocelyn,Platos).

      test(cuales_son_los_gustos_de_jean_gourmet, 
        set(Platos == [asadodetira,chinchulines,mollejas])) :-
          gustos(jeangourmet,Platos).

:- end_tests(parrilla).

menuParrilla(Platos) :- carnes(Platos).
menuParrilla(Platos) :- platosVegetarianos(Platos).

carnes(chinchulines).
carnes(mollejas).
carnes(chorizo).
carnes(asadodetira).
carnes(vacio).
carnes(bondiola).

platosVegetarianos(papaalplomo).
platosVegetarianos(provoleta).

menuCaro(mollejas).
menuCaro(chinchulines).

% Nos piden conocer:

%- Los gustos que comería Jocelyn, que solo come mollejas o platos vegetarianos

gustos(jocelyn,Platos):-platosVegetarianos(Platos).
gustos(jocelyn,mollejas).

%- Los gustos que come Jean Gourmet, que come menúes caros y asado de tira, pero nunca vacío.

gustos(jeangourmet,Platos):-menuCaro(Platos).
gustos(jeangourmet,asadodetira).

/*
> **Para pensar:** ¿cómo se modela que Jean Gourmet no come vacío? ¿Con qué concepto está relacionado?

simplemente no se modela, ya que en prolog, al trabajar con modelos de universo cerrado, lo que no se declara, se considera falso

- Indique cuál es la consulta para saber los menúes que comerían Jocelyn y Jean Gourmet.

gustos(jocelyn,Platos).

gustos(jeangourmet,Platos).

luego recorreria la lista apretando espacio hata que la terminal me devuelva el valor False, lo cual indica que no encontro mas resultados

> El testeo unitario es opcional, debe quedar claro cómo resuelve los requerimientos pedidos (qué consultas se hacen).

*/