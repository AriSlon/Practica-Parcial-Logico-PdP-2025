%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 2 - La copa de las casas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Saber si un mago es buen alumno, que se cumple si hizo alguna acción y ninguna de las cosas que hizo se considera una mala acción (que son aquellas que provocan un puntaje negativo).

hizo(harry, fueraDeCama).
hizo(hermione, ir(tercerPiso)).
hizo(hermione, ir(seccionRestringida)).
hizo(harry, ir(bosque)).
hizo(harry, ir(tercerPiso)).
hizo(draco, ir(mazmorras)).
hizo(ron, buenaAccion(50, ganarAjedrezMagico)).
hizo(hermione, buenaAccion(50, salvarAmigos)).
hizo(harry, buenaAccion(60, ganarleAVoldemort)).

lugarProhibido(bosque, 50).
lugarProhibido(seccionRestringida, 10).
lugarProhibido(tercerPiso, 75).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

hizoAlgunaAccion(Mago):-
    hizo(Mago, _).

hizoAlgoMalo(Mago):-
    hizo(Mago, Accion),
    puntajeQueGenera(Accion, Puntaje),
    Puntaje < 0.

puntajeQueGenera(fueraDeCama, -50).

puntajeQueGenera(irA(Lugar), PuntajeQueResta):-
    lugarProhibido(Lugar, Puntos),
    PuntajeQueResta is Puntos * -1.

puntajeQueGenera(buenaAccion(Puntaje, _), Puntaje).


esBuenAlumno(Mago):-
    hizoAlgunaAccion(Mago),
    not(hizoAlgoMalo(Mago)).

%Saber si una acción es recurrente, que se cumple si más de un mago hizo esa misma acción.

esRecurrente(Accion):-
    hizo(Mago, Accion),
    hizo(Otromago, Accion),
    Mago \= OtroMago.

%Saber cuál es el puntaje total de una casa, que es la suma de los puntos obtenidos por sus miembros.

puntajeTotal(Casa, Puntaje):-
    findall(Puntos,
            (esDe(Mago, Casa), hizo(Mago, Accion), puntosQueGenera(Accion, Puntos)),
            ListaDePuntos)
    sum_list(ListaDePuntos, Puntaje).