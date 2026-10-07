:- consult('grafo.pl').

% si_no(+Meta): imprime true/false para consultas de si/no
si_no(Consulta, Meta) :-
    format("~n?- ~w~n", [Consulta]),
    (   call(Meta) -> writeln('true.') ; writeln('false.') ).

% todas(+Consulta, +Plantilla, :Meta): imprime cada solucion de Meta
todas(Consulta, Plantilla, Meta) :-
    format("~n?- ~w~n", [Consulta]),
    findall(Plantilla, Meta, Lista),
    (   Lista == []
    ->  writeln('false.')
    ;   forall(member(L, Lista), (print(L), nl))
    ).

ejecutar :-
    writeln('##### PREGUNTAS DE LA DIAPOSITIVA #####'),

    % 1. Existe conexion entre Saskatoon y Vancouver?
    si_no('conectado(saskatoon, vancouver).', conectado(saskatoon, vancouver)),
    si_no('conectado(vancouver, saskatoon).', conectado(vancouver, saskatoon)),

    % 2. Con que nodos esta conectado Regina y costo de cada conexion?
    todas('conexion(regina, Z, C).  % formato Z-C',
          Z-C, conexion(regina, Z, C)),
    todas('camino(regina, Z, C, Ruta).  % formato Z-C-Ruta',
          Z-C-R, camino(regina, Z, C, R)),

    % Costo minimo por destino
    format("~n?- costo minimo de regina a cada destino~n"),
    setof(Z2, C2^conexion(regina, Z2, C2), Destinos),
    forall(member(D, Destinos),
           ( aggregate_all(min(Cm), conexion(regina, D, Cm), Min),
             format("~w: ~w~n", [D, Min]) )),

    writeln('\n##### REGLAS NUEVAS #####'),

    % 3. Regla: un nodo tiene aristas
    si_no('tiene_aristas(vancouver).', tiene_aristas(vancouver)),
    si_no('tiene_aristas(winnipeg).',  tiene_aristas(winnipeg)),
    si_no('tiene_aristas(toronto).',   tiene_aristas(toronto)),
    format("~n?- setof(N, tiene_aristas(N), L).~n"),
    setof(N, tiene_aristas(N), Nodos), print(Nodos), nl,

    % 4. Regla: costo de X a Z pasando por Y
    todas('costo_por(vancouver, saskatoon, winnipeg, C).  % formato C',
          C4, costo_por(vancouver, saskatoon, winnipeg, C4)),
    todas('costo_por(vancouver, calgary, regina, C).  % formato C',
          C5, costo_por(vancouver, calgary, regina, C5)),
    todas('costo_por(vancouver, regina, edmonton, C).  % formato C',
          C6, costo_por(vancouver, regina, edmonton, C6)),
    todas('costo_por(edmonton, Y, winnipeg, C).  % formato Y-C',
          Y-C7, costo_por(edmonton, Y, winnipeg, C7)),

    writeln('\n##### PREGUNTA MAS INTERESANTE #####'),

    % 5. Es posible viajar de Edmonton a Calgary?
    si_no('conectado(edmonton, calgary).', conectado(edmonton, calgary)),
    todas('camino(edmonton, calgary, C, Ruta).  % formato C-Ruta',
          C8-R8, camino(edmonton, calgary, C8, R8)),
    si_no('conectado(calgary, edmonton).', conectado(calgary, edmonton)),
    todas('camino(calgary, edmonton, C, Ruta).  % formato C-Ruta',
          C9-R9, camino(calgary, edmonton, C9, R9)).
