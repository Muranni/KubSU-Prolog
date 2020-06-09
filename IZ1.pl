/*Число называется совершенным, если равно сумме своих делителей. 
Назовем число избыточным, если сумма его делителей больше самого числа. 
Минимальное число с избытком – это 12. 
Найдите количество чисел, меньшее 20000, которые нельзя представить в виде суммы двух чисел с избытком.
12, 18, 20, ...*/

checkIzb(C) :-
    checkIzb(C, 1, 0).

checkIzb(C, D, S) :-
    C mod D =:= 0,
    !,
    D1 is D+1,
    S1 is S+D,
    checkIzb(C, D1, S1).

checkIzb(C, D, S) :-
    D=<C/2,
    !,
    D1 is D+1,
    checkIzb(C, D1, S).

checkIzb(C, _, S) :-
    S>C,
    !.

gottaCatchThemAll :-
    gottaCatchThemAll(24, 23).

gottaCatchThemAll(C, Izb) :-
    C1 is C div 2,
    findFirst(C, C1),
    Cn is C+1,
    gottaCatchThemAll(Cn, Izb).

gottaCatchThemAll(_, 19999) :-
    !.

gottaCatchThemAll(26, _) :-
    !.
    
findFirst(C, C1) :-
    C1>=12,
    checkIzb(C1),
    !,
    C2 is C-C1,
    checkIzb(C2),
    !.

findFirst(C, C1) :-
    C1>12,
    !,
    C11 is C1-1,
    findFirst(C, C11).

findFirst(C, _) :-
    Cn is C+1,
    gottaCatchThemAll(Cn, Izb).