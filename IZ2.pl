/* Для введенного списка построить список с номерами элемента, который повторяется наибольшее число раз. */
searchForMaxEntries :- %Главный предикат, для запуска вызывать его
    write("Введите количество элементов списка"),
    read(N),
    nl,
    write("Введите элементы списка"),
    readList([Head|Tail], N), 
    M is Head,
    K is 1,
    searchForMaxEntries([Head|Tail], M, K, Mr, Kr),
    buildIndexList([Head|Tail], Mr, Kr).

readList(A, N) :- %Заполнение списка элементами, вводимыми с клавиатуры
    readList([], A, 0, N).

readList(A, A, N, N) :-
    !.

readList(List, A, I, N) :-	
    I1 is I+1,
    read(X),
    append(List, [X], List1),
	readList(List1, A, I1, N).

searchForMaxEntries([Elem|Tail], M, K, Mr, Kr) :- %Поиск числа, которое повторяется наибольшее число раз
    searchEntries(Elem, Tail, M, M1, K, K1),
    searchForMaxEntries(Tail, M1, K1, Mr, Kr).

searchForMaxEntries([], M, K, Mr, Kr) :-
    Mr is M,
    Kr is K,
    !.

searchEntries(Elem, Tail, M, M1, K, K1) :- %Поиск числа повторов элемента в списке
    searchEntries(Elem, Tail, M, M1, K, K1, 1).

searchEntries(Elem, [Head|Tail], M, M1, K, K1, C) :-
    equals(Elem, Head),
    C1 is C+1,
    searchEntries(Elem, Tail, M, M1, K, K1, C1);
    searchEntries(Elem, Tail, M, M1, K, K1, C),
    !.
    
searchEntries(Elem, [], M, M1, K, K1, C) :-
    C>K,
    K1 is C,
    M1 is Elem;
    K1 is K,
    M1 is M,
    !.

equals(Elem, Head) :-
    Elem = Head,
    !.

buildIndexList([Head|Tail], Mr, Kr) :- %Построение списка с номерами элемента, который повторяется наибольшее число раз
    buildIndexList([Head|Tail], Mr, Kr, [], 1, 0).
    
buildIndexList([Head|Tail], Mr, Kr, List, C, I) :-
    equals(Mr, Head),
    !,
    C1 is C+1,
    I1 is I+1,
    append(List, [C], List2),
    buildIndexList(Tail, Mr, Kr, List2, C1, I1);
    C1 is C+1,
    buildIndexList(Tail, Mr, Kr, List, C1, I).

buildIndexList(_, _, Kr, List, _, Kr) :-
    write("Построенный список: "),
    write(List),
    !.