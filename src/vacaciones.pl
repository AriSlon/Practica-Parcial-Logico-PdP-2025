va(dodain, pehuenia).
va(dodain, sanMartinDeLosAndes).
va(dodain, esquel).
va(dodain, sarmiento).
va(dodain, camarones).
va(dodain, elbolson).

va(alf, bariloche).
va(alf, elBolson).
va(alf, sanMartinDeLosAndes).

va(nico, marDelPlata).

va(vale, calafate).
va(vale, elBolson).

va(martu, Lugar):-
    va(nico, Lugar).

va(martu, Lugar):-
    va(alf, Lugar).

persona(Persona):-
    va(Persona, _).

persona(juan).

atraccion(esquel, parqueNacional(losAlerces)).
atraccion(esquel, excursion(trochita)).
atraccion(esquel, excursion(trevelin)).
atraccion(pehuenia, cerro(bateaMahuida, 2000)).
atraccion(pehuenia, cuerpoAgua(si, 14)).
atraccion(pehuenia, cuerpoAgua(si, 19)).
atraccion(marDelPlata, cuerpoAgua(si, 19)).

costoDeVida(sarmiento, 100).
costoDeVida(esquel, 150).
costoDeVida(pehuenia, 180).
costoDeVida(sanMartinDeLosAndes, 150).
costoDeVida(camarones, 135).
costoDeVida(playaDoradas, 170).
costoDeVida(bariloche, 140).
costoDeVida(calafate, 240).
costoDeVida(elBoson, 145).
costoDeVida(marDelPlata, 140).




%Queremos saber qué vacaciones fueron copadas para una persona. Esto ocurre cuando todos los lugares a visitar tienen por lo menos una atracción copada. 
%un cerro es copado si tiene más de 2000 metros
%un cuerpoAgua es copado si se puede pescar o la temperatura es mayor a 20
%una playa es copada si la diferencia de mareas es menor a 5
%una excursión que tenga más de 7 letras es copado
%cualquier parque nacional es copado
%El predicado debe ser inversible. 

atraccionCopada(cerro(_, Altura)):-
    Altura > 2000.

atraccionCopada(cuerpoAgua(si, _)).

atraccionCopada(cuerpoAgua(_, Temperatura)):-
    Temperatura > 20.

atraccionCopada(playa(Diferencia)):-
    mod(Diferencia) < 5.

atraccionCopada(parqueNacional(_)).

lugarCopado(Lugar):-
    atraccion(Lugar, Atraccion),
    atraccionCopada(Atraccion).

fueronCopadas(Persona):-
    persona(Persona),
    forall(va(Persona, Lugar), lugarCopado(Lugar)).

%Cuando dos personas distintas no coinciden en ningún lugar como destino decimos que no se cruzaron. Por ejemplo, Dodain no se cruzó con Nico ni con Vale (sí con Alf en San Martín de los Andes). Vale no se cruzó con Dodain ni con Nico (sí con Alf en El Bolsón). El predicado debe ser completamente inversible.

noSeCruzaron(Persona, OtraPersona):-
    persona(Persona),
    persona(OtraPersona),
    Persona \= OtraPersona,
    forall(va(Persona, Lugar), not(va(OtraPersona, Lugar))).

%Queremos saber si unas vacaciones fueron gasoleras para una persona. Esto ocurre si todos los destinos son gasoleros, es decir, tienen un costo de vida menor a 160. Alf, Nico y Martu hicieron vacaciones gasoleras.
%El predicado debe ser inversible.
destinoGasolero(Destino):-
    costoDeVida(Destino, Costo),
    Costo < 160.

fueronGasoleras(Persona):-
    persona(Persona),
    forall(va(Persona, Lugar), destinoGasolero(Lugar)).
 