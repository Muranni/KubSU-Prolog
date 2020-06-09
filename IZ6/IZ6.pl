sub_set([], []). 
sub_set([H|Sub_set], [H|Set]) :- %Разбиение на подмножества
	sub_set(Sub_set, Set).
sub_set(Sub_set, [H|Set]) :-
	sub_set(Sub_set, Set).

read_list(A, N) :- %Ввод списка
	read_list([], A, 0, N). 
read_list(A, A, N, N) :-
	!.
read_list(List, A, I, N) :-	
	I1 is I+1,
	read(X),
	append(List, [X], List1),
	read_list(List1, A, I1, N).

listLen(List, Result) :- %Длина списка
	listLen(List, Result, 0). 
listLen([], Acc, Acc) :- 
	!.
listLen([H|T], Result, Acc) :- 
	AccN is Acc + 1, 
	listLen(T, Result, AccN).

inputEdges(EdgesNumber) :- %Ввод ребер
	write('Enter first vertex name: '), 
	read(FVertexName),
	write('Enter second vertex name: '), 
	read(SVertexName),
	assert(edge(FVertexName, SVertexName)),
	assert(edge(SVertexName, FVertexName)),
	EdgesNumber_ is EdgesNumber - 1,
	inputEdges(EdgesNumber_).
	
inputEdges(0) :- 
	!.

graphWorker :- %Основной предикат, задавать вопросы ему
	write('Input vertexes number: '), 
	read(VertexesNumber),
	read_list(Vertexes, VertexesNumber),
	write('Entered vertexes: '), 
	write(Vertexes), nl, nl,
	dynamic(edge/2),
	write('Input edges number: '), 
	read(EdgesNumber),
	inputEdges(EdgesNumber),
	dynamic(result/1),
	not(maximumIndependentSet(Vertexes)),
	abolish(vertex/1),
	abolish(edge/1),
	abolish(result/1).
	
	graphWorkerTest :- % Пример с графом на фото
	Vertexes = ['a', 'b', 'c', 'd', 'e', 'f'],
	dynamic(edge/2),
	assert(edge('a', 'b')),
	assert(edge('a', 'f')),
	assert(edge('b', 'a')),
	assert(edge('b', 'c')),
	assert(edge('b', 'e')),
	assert(edge('c', 'b')),
	assert(edge('c', 'f')),
	assert(edge('c', 'd')),
	assert(edge('d', 'c')),
	assert(edge('d', 'e')),
	assert(edge('e', 'd')),
	assert(edge('e', 'b')),
	assert(edge('e', 'f')),
	assert(edge('f', 'e')),
	assert(edge('f', 'a')),
	assert(edge('f', 'c')),
	dynamic(result/1),
	not(maximumIndependentSet(Vertexes)),
	abolish(vertex/1),
	abolish(edge/2),
	abolish(result/1).

isNotConnectedAll([H|T]) :- %Проверка всех пар вершин на несмежность друг с другом
	isNotConnectedAll_(H, T),
	isNotConnectedAll(T).

isNotConnectedAll([]) :- 
	!.

isNotConnectedAll_(V, [H|T]) :- %Проверка на несмежность вершины V со другими вершинами из списка
	not(edge(V, H)),
	not(edge(H, V)),
	isNotConnectedAll_(V, T).
	
isNotConnectedAll_(V, []) :- 
	!.

maximumIndependentSet(Vertexes) :- %Проверка всех подмножеств вершин до нахождения независимого, которое будет максимальным
	forall(
		(
			sub_set(S, Vertexes),
			isNotConnectedAll(S)
		),

		(
			listLen(S, SLen),
			write('Число внутренней устойчивости графа - '), 
			write(SLen), nl,
			fail, 
			!
		)
	),
	fail.