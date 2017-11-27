a([X,Y],[Y,Z],[X,Z]).
b(X,Y,Z):-
	a(X,Y,Z);
	[A,A]=X,
	write(A).
checktransitive(S, R):-
	graph(S,R,G),
	length(S,N),
	matrixtrans(G, G, G1, N,N),
	G==G1.

transitiveclosure(S, R, G1):-
	graph(S,R,G),
	length(S,N),
	matrixtrans(G, G, G2, N,N),
	transmatrixrow(S, G2,[], G1, N).
def(S,0,G1,G1,N1,N2).
def(S,1,G1,G2,N1,N2):-
	length(S,X),
	N3 is X-N2,
	N4 is X-N1,
	getvalue(S, N6, N3),
	getvalue(S, N7, N4),
	N5=[N6,N7],
	append(G1,[N5],G2).
transmatrixcol(S,[],G,G,0,N2).
transmatrixcol(S,[H|T],G1,G2,N, N2):-
	N1 is N-1,
	def(S,H,G1,G3,N,N2),
	transmatrixcol(S,T,G3,G2,N1, N2).
transmatrixrow(S,[],G,G,0).
transmatrixrow(S,[H|T],G1,G3, N):-
	N1 is N-1,
	length(S,X),
	transmatrixcol(S,H,G1,G2,X,N),
transmatrixrow(S,T,G2,G3,N1),!.


abc([H|T],0,H).
abc([H|T], C, X):-
	C1 is C-1,
	abc(T,C1,X),!.
colextract([],[],C,0).
colextract([H|T], [H1|T1], C, N):-
	N1 is N-1,
	abc(H, C, H1),
	colextract(T,T1, C, N1).

matrixtrans(M,K,T,0,N):-
	T=[].
matrixtrans(M,[H|T], [H1|T1], C, N):-
	C1 is C-1,
	N1 is N-C,
	length([H|T],NX),
	NY is N-NX,
	rowtrans(M, H, H1, N, N, NY),
	modify(M,H1,N1, MX),
	matrixtrans(MX,T, T1, C1, N),!.
rowtrans(M,H,H1,N,0, NY):-
	H1=H.
rowtrans([HM|TM], [H2|T2],H1, N, C, NY):-
	C1 is C-1,
	N1 is N-C,

	colextract([HM|TM],L,N1,N),
	write(C),nl,
	checkpath([H2|T2],L,L1),
	write(L),nl,
	checkor(L1,X1),
	getvalue([H2|T2],NH2,N1),
	or(X1,NH2,X),
	modify([H2|T2],X,N1,H3),

	modify([HM|TM], H3, NY, L9),
	write(L9),
	rowtrans(L9,H3,H1,N,C1, NY).

graph(S, R, G):-
	length(S, CS),
	length(R, CR),	
	app0(CS, [0], [], L1),
	app0(CS, [L1], [], G1),
	recrel(R, CR, S, G1, G).
	
recs(0, Y, [H|T], [HX|TX]):-
	modify(H, 1, Y, HX),
	TX=T,!.

recs(X, Y, [H1|T1], [H2|T2]):-
	X1 is X-1,
	H2=H1,
	recs(X1, Y, T1, T2).
recrel([], 0, _, [H3|T3], [H3|T3]).
recrel([HR|TR], C, [HS|TS],[H1|T1], [H2|T2]):-
	C1 is C-1,
	(X,Y)=HR,
	getpos([HS|TS], X, IX),
	getpos([HS|TS], Y, IY),
	recs(IX, IY,[H1|T1], [H3|T3]),
	recrel(TR, C1, [HS|TS], [H3|T3], [H2|T2]).

or(0,0,0).
or(_,_,1).
and(1,1,1).
and(_,_,0).
checkor([0],0).
checkor([1],1).
checkor([H|T],X):-
	checkor(T,X1),
	or(X1,H,X),!.

checkpath([],[],[]).
checkpath([H1|T1],[H2|T2],[H3|T3]):-
	and(H1,H2,H3),
	checkpath(T1,T2,T3),!.


getpos([N|_], N, I):-
	I=0,!.
getpos([_|T], N, I):-
	getpos(T, N, I1),
	I is I1+1.


getvalue([N|_], N, 0).
getvalue([_|T], N, I):-
	I1 is I-1,
	getvalue(T, N, I1),!.
modify([_|T], V, 0, X):-
	X = [V|T],!.
modify([H|T], V, P, X):-
	P1 is P-1,
	modify(T, V, P1, X1),
	X = [H|X1].
app0(1, L1, L2, L3):-
	append(L1, L2, L3),!.
app0(C, L1, L2, L3):-
	append(L1, L2, L4),
	C1 is C-1,
	app0(C1, L1, L4, L3),!.

	
