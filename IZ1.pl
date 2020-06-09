/*Число называется совершенным, если равно сумме своих делителей. 
Назовем число избыточным, если сумма его делителей больше самого числа. 
Минимальное число с избытком – это 12. 
Найдите количество чисел, меньшее 20000, которые нельзя представить в виде суммы двух чисел с избытком.
12, 18, 20, ...*/
gottaCatchThemAll :- %Основной предикат, задавать вопрос ему
    gottaCatchThemAll(25, 23, 20000). /*Рассматриваем числа от 25 т.к. минимальное число, которое
									    можно представить в виде суммы 2 избыточных чисел - 24,*/
gottaCatchThemAll(C, Izb, Lim)        /*следовательно имеем 23 числа (1..23), удовлетворяющие заданию*/
    C<Lim,
    C1 is C div 2,
    checkSum(C, C1, Izb, Lim),
    !.

gottaCatchThemAll(Lim, Izb, _) :-
    write("Количество чисел, удовлетворяющих условию = "),
    write(Izb),
    !.

checkIzb(C) :- %Проверка числа на избыточность
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

checkSum(C, C1, Izb, Lim) :- %Проверка числа, можно ли его представить в виде суммы 2 избыточных чисел
    C1>=12,
    checkIzb(C1),
    C2 is C-C1,
    checkIzb(C2),
    Cn is C+1,
    gottaCatchThemAll(Cn, Izb, Lim);
    C1>12,
    C11 is C1-1,
    checkSum(C, C11, Izb, Lim).

checkSum(C, _, Izb, Lim) :-
    Cn is C+1,
    Izb2 is Izb+1,
    gottaCatchThemAll(Cn, Izb2, Lim).