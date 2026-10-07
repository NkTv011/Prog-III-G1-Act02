% ============================================================
% Actividad: Backtracking y SLD
% Grafo dirigido de ciudades de Canada (diapositiva "Y si se filtra?")
% arista(Origen, Destino, Costo).
% ============================================================

% --- Hechos: aristas dirigidas con su costo ---
arista(vancouver, edmonton, 16).   % s  -> v1
arista(vancouver, calgary,  13).   % s  -> v2
arista(calgary,   edmonton,  4).   % v2 -> v1
arista(edmonton,  saskatoon, 12).  % v1 -> v3
arista(saskatoon, calgary,   9).   % v3 -> v2
arista(calgary,   regina,   14).   % v2 -> v4
arista(regina,    saskatoon, 7).   % v4 -> v3
arista(saskatoon, winnipeg, 20).   % v3 -> t
arista(regina,    winnipeg,  4).   % v4 -> t

% --- Regla 1: camino entre dos nodos ---
% camino(X, Z, Costo, Ruta): hay un camino dirigido de X a Z con ese
% costo total. Se lleva la lista de nodos visitados para evitar ciclos
% (el grafo tiene el ciclo calgary -> regina -> saskatoon -> calgary,
% sin esa lista el backtracking no terminaria). Los caminos son simples:
% ningun nodo se repite, por lo que conectado(X, X) es siempre falso.
camino(X, Z, Costo, Ruta) :-
    cam(X, Z, [X], Costo, RutaInv),
    reverse(RutaInv, Ruta).

cam(X, Z, Visitados, Costo, [Z|Visitados]) :-
    arista(X, Z, Costo),
    \+ member(Z, Visitados).
cam(X, Z, Visitados, Costo, Ruta) :-
    arista(X, W, C1),
    \+ member(W, Visitados),
    cam(W, Z, [W|Visitados], C2, Ruta),
    Costo is C1 + C2.

% --- Regla 2: conexion (existe algun camino) ---
conectado(X, Z) :-
    camino(X, Z, _, _).

% --- Regla 3: un nodo tiene aristas (entrantes o salientes) ---
tiene_aristas(N) :-
    arista(N, _, _).
tiene_aristas(N) :-
    arista(_, N, _).

% --- Regla 4: costo de ir de X a Z pasando por Y ---
% Se busca un camino X -> Z cuya ruta contenga a Y como nodo intermedio.
costo_por(X, Y, Z, Costo) :-
    camino(X, Z, Costo, Ruta),
    member(Y, Ruta),
    Y \== X,
    Y \== Z.

% --- Regla 5 (apoyo): conexiones de un nodo con su costo ---
conexion(X, Z, Costo) :-
    camino(X, Z, Costo, _).
