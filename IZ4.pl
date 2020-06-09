kid("Алик").
kid("Боря").
kid("Витя").
kid("Лена").
kid("Даша").

/* Пятеро детей Алик, Боря, Витя, Лена и Даша приехали в лагерь из 5 разных городов: 
 * Харькова, Умани, Полтавы, Славянска и Краматорска. Есть 4 высказывания: 
 * 1) Если Алик не из Умани, то Боря из Краматорска. 
 * 2) Или Боря, или Витя приехали из Харькова. 
 * 3) Если Витя не из Славянска, то Лена приехала из Харькова. 
 * 4) Или Даша приехала из Умани, или Лена из Краматорска. Кто откуда приехал?*/

firstRule([B, "Умань"],[E, "Краматорск"]) :-
    not(B = "Алик"),
    E = "Боря";
    B = "Алик".

secondRule([A, "Харьков"]) :-
    A = "Боря"; 
    A = "Витя".
    
thirdRule([A, "Харьков"],[D, "Славянск"]) :-
    not(D = "Витя"), 
    A = "Лена";
    D = "Витя".
    
fourthRule([B, "Умань"],[E, "Краматорск"]) :-
    B = "Даша";
    E = "Лена".

jdiMenya :-
    kid(A),
    kid(B),
    kid(C),
    kid(D),
    kid(E),
    not(A = B), 
    not(A = C),
    not(A = D),
    not(A = E),
    not(B = C),
    not(B = D),
    not(B = E),
    not(C = D),
    not(C = E),
    not(D = E),
    firstRule([B, "Умань"],[E, "Краматорск"]), 
    secondRule([A, "Харьков"]),
    thirdRule([A, "Харьков"],[D, "Славянск"]),
    fourthRule([B, "Умань"],[E, "Краматорск"]),
    write(A), write(" "), write("Харьков"), nl,
	write(B), write(" "), write("Умань"), nl,
    write(C), write(" "), write("Полтава"), nl,
	write(D), write(" "), write("Славянск"), nl,
	write(E), write(" "), write("Краматорск"), !.