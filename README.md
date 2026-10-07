# Actividad 02 - Backtracking y SLD (Programación III, Grupo 1)

Programa en Prolog con un grafo dirigido de ciudades de Canadá, reglas para
caminos, conexiones y costos, y las consultas propuestas por el profesor.

**Integrantes:** Nicolás Tovar Gaviria, Santiago Velásquez

## Estructura

- `src/grafo.pl`: hechos `arista/3` y reglas (`camino`, `conectado`, `conexion`, `tiene_aristas`, `costo_por`).
- `src/consultas.pl`: script que ejecuta todas las consultas.
- `resultados/salida.txt`: salida real de las consultas.
- `informe/`: informe en PDF.

## Cómo ejecutarlo

Requiere [SWI-Prolog](https://www.swi-prolog.org/). Desde la carpeta `src/`:

```
swipl -q -g ejecutar -t halt consultas.pl
```
