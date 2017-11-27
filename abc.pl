transitive([W,X],[Y,Z],A):-
	X=\=Y,
	W=\=Z,
	A=[],!.
trans([X,Y],[Y,X],[X,X]).
trans([W,X],[Y,Z],A):-
	A=[],!.
transitive([Y,X],[Z,Y],[Z,X]).
transitive([X,Y],[Y,Z],[X,Z]).

checktransitive(S,R):-
	def(R,R,R,G1),
	%write(G1),
	length(R)==length(G1).
closure(S,R):-
	def(R, R, R, G1),
	length(G1,X),
	write("Transitive Closure="),
	print(G1,X).
print([],0).
print([H|T],C):-
	C1 is C-1,
	write(H),
	print(T,C1).	
%abc([],_,G,G).
%abc(_,[],G,G).

append1(A,X,[],X,A).
append1(A,X,Y,Z,B):-
	memberfunc(Y,X,G,C),
	%write(G),
	(G==0,
	append(X,[Y],Z),
	append(A,[Y],B)),!;
	Z=X,
	B=A.
	
memberfunc(H,[],G,X):-
	X=[],
	G=0.
memberfunc(H, [H1|T1],G,X):-
	(H==H1,
	G=1,
	X=T1),!;
	memberfunc(H,T1, G,X),!.


def(_,[],G2,G2).
def(R, [H|T],G1,G2):-
	abc(R,[H|T],G1,G3),
	%write(G3),nl,
	memberfunc(H,G3,G,X),
	%write(X),nl,
	def(G3,X,G3,G2),!.

abc([],_,G2,G2).
abc([H1|T1], [H|T], G1, G2):-
	%write(H),
	%write(H1),
	trans(H,H1,X),
	%write(X),nl,
	append1(T1,G1,X,G4,T3),
	transitive(H,H1,Z),
	%write(H),
	%write(H1),
	%write(Z),nl,
	%write(T3),
	append1(T3, G4, Z, G3, T2),
	%write(G3),nl,
	abc(T2, [H|T], G3, G2),!. 


