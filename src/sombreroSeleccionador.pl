%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 1 - Sombrero Seleccionador
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

casa(ravenclaw).
casa(gryffindor).
casa(hufflepuff).
casa(slytherin).

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).

tieneCaracteristica(harry, corajudo).
tieneCaracteristica(harry, amistoso).
tieneCaracteristica(harry, orgulloso).
tieneCaracteristica(harry, inteligente).

tieneCaracteristica(draco, orgulloso).
tieneCaracteristica(draco, inteligente).

tieneCaracteristica(hermione, inteligente).
tieneCaracteristica(hermione, orgulloso).
tieneCaracteristica(hermione, responsable).

caracteristicaBuscada(ravenclaw, inteligente).
caracteristicaBuscada(ravenclaw, responsable).

caracteristicaBuscada(gryffindor, corajudo).

caracteristicaBuscada(hufflepuff, amistoso).

caracteristicaBuscada(slytherin, orgulloso).
caracteristicaBuscada(slytherin, inteligente).

odiariaEntrar(harry, slytherin)
odiariaEntrar(draco, hufflepuff)

%¿Por que puedo hacer esto? Porque en el propio enunciado te da la pauta que todo mago que ingrese a la base de coinocimientos vendra acompañado con su respectivo tipo de sangre.
%Entonces, puedo generar todos los magos existentes a partir del rpedicado que los vincula con su tipo de sangre.
mago(Mago):-
    sangre(Mago, _).

%Saber si una casa permite entrar a un mago, lo cual se cumple para cualquier mago y cualquier casa excepto en el caso de Slytherin, que no permite entrar a magos de sangre impura.
permiteEntrar(Casa, Mago):-
    casa(Casa),
    mago(Mago),
    Casa \= slytherin.

permiteEntrar(slytherin, Mago):-
    sangre(Mago, TipoDeSangre),
    TipoDeSangre \= impura.

%Saber si un mago tiene el carácter apropiado para una casa, lo cual se cumple para cualquier mago si sus características incluyen todo lo que se busca para los integrantes de esa casa, independientemente de si la casa le permite la entrada.

tieneCaracterApropiado(Mago, Casa):-
    casa(Casa),
    mago(Mago),    
    forall(caracteristicaBuscada(Casa, Carcateristica), tieneCaracteristica(Mago, Caracteristica)).

%Determinar en qué casa podría quedar seleccionado un mago sabiendo que tiene que tener el carácter adecuado para la casa, la casa permite su entrada y además el mago no odiaría que lo manden a esa casa. Además Hermione puede quedar seleccionada en Gryffindor, porque al parecer encontró una forma de hackear al sombrero.

puedeQuedarSeleccionado(Mago, Casa):-
    tieneCaracterApropiado(Mago, Casa),
    permiteEntrar(Casa, Mago),
    not(odiariaEntrar(Mago, Casa)).

puedeQuedarSeleccionado(hermione, gryffindor).

%Definir un predicado cadenaDeAmistades/1 que se cumple para una lista de magos si todos ellos se caracterizan por ser amistosos y cada uno podría estar en la misma casa que el siguiente. No hace falta que sea inversible, se consultará de forma individual.
todosAmistosos(Magos):-
    forall(member(Mago, Magos), tieneCaracteristica(Mago, amistad)).

cadenaDeCasas([Mago1, Magos2 | MagosSiguientes]):-
    puedeQuedarSeleccionado(Mago1, Casa),
    puedeQuedarSeleccionado(Mago2, Casa),
    cadenaDeCasas([Magos2 | MagosSiguientes]).
cadenaDeCasas([_]).
cadenaDeCasas([]).

cadenaDeAmistades(Magos):-
    todosAmistosos(Magos),
    cadenaDeCasas(Magos).