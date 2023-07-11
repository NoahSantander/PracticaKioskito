% 1
atiende(dodain, [lunes, miercoles, viernes], 9, 15).
atiende(lucas, [martes], 10, 20).
atiende(juanC, [sabado, domingo], 18, 22).
atiende(juanFdS, [jueves], 10, 20).
atiende(juanFdS, [viernes], 12, 20).
atiende(martu, [miercoles], 23, 0).
atiende(leoC, [lunes, miercoles], 14, 18).
atiende(vale, [lunes, miercoles, viernes], 9, 15).
atiende(vale, [sabado, domingo], 18, 22).
atiende(maiu, [martes, miercoles], 0, 8).

% No es necesario hacer nada para decir que nadie hace el mismo horario de leoC, por Principio de Universo cerrado. Si no esta en mi base de conocimiento, entonces nadie hace el mismo horario

% 2
% quienAtiende/3 Relaciona un día y hora con una persona, en la que dicha persona atiende el kiosko
quienAtiende(Persona, Dia, Hora):-
    atiende(Persona, Dias, HoraLlegada, HoraSalida),
    member(Dia, Dias),
    between(HoraLlegada, HoraSalida, Hora).

% 3
% todosMenosElQueAtiende/2 Saber todas las personas que atienden y no sean la persona que quiero
todosMenosElQueAtiende(Persona, OtraPersona):-
    atiende(OtraPersona, _, _, _),
    OtraPersona \= Persona.

% foreverAlone/3 Saber si una persona en un día y horario determinado está atendiendo ella sola
foreverAlone(Persona, Dia, Hora):-
    quienAtiende(Persona, Dia, Hora),
    forall(todosMenosElQueAtiende(Persona, Personas), not(quienAtiende(Personas, Dia, Hora))).  

% 4
% podriaAtender/2 Relaciona qué personas podrían estar atendiendo el kiosko en algún momento de ese día
podriaAtender(Persona, Dia):-
    quienAtiende(Persona, Dia, _).

% 5
venta(dodain, 10,[producto(golosinas, 1200), producto(cigarrillos, [jockey]), producto(golosinas, 50)]).
venta(dodain, 12,[producto(bebida, alcoholica, 8), producto(bebida, noAlcoholica, 1), producto(golosinas, 10)]).
venta(martu, 12, [producto(golosinas, 1000), producto(cigarillos, [chesterfield, colorado, parisiennes])]).
venta(lucas, 11, [producto(golosinas, 600)]).
venta(lucas, 18, [producto(bebida, noAlcoholica, 2), producto(cigarillos, [derby])]).

% cumpleConCaracteristicas/1 Saber si un producto cumple cpn las caracteristicas de ser importante
cumpleCaracteristicas(producto(golosinas, Precio)):-
    Precio > 100.

cumpleCaracteristicas(producto(cigarillos, Marcas)):-
    length(Marcas, CantMarcas),
    CantMarcas > 2.

cumpleCaracteristicas(producto(bebida, noAlcoholica, Cantidad)):-
    Cantidad > 5.

cumpleCaracteristicas(producto(bebida, alcoholica, _)).

% esVentaImportante/1 Saber si el primer elemento de una venta fue importante
esVentaImportante(Venta):-
    nth0(0, Venta, Producto),
    cumpleCaracteristicas(Producto).

% esSuertudo/1 Relaciona si para todos los días en los que vendió, la primera venta que hizo fue importante
esSuertudo(Vendedor):-
    venta(Vendedor, _, _),
    forall(venta(Vendedor, _, Venta), esVentaImportante(Venta)).