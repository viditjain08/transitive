/*   NAME - VIDIT JAIN  , ID - 2016A7PS0064P
 *   NAME - PIYUSH GARG , ID - 2016A7PS0035P  */
/*   PLEASE REFER TO THE README FILE FOE THE INPUT  */


trans([X,Y],[Y,X],[X,X]).
trans([_,_],[_,_],A):-
	A=[],!.
transitive([W,X],[Y,Z],A):-
	X=\=Y,
	W=\=Z,
	A=[],!.
transitive([Y,X],[Z,Y],[Z,X]).
transitive([X,Y],[Y,Z],[X,Z]).

%Checking Transitive Relation
checkTransitive(S,R):-
	def(R,R,R,G1),
	length(R)==length(G1).

%Finding Transitive Closure
closure(S,R):-
	def(R, R, R, G1),
	length(G1,X),
	write("Transitive Closure="),
	print(G1,X).

%Creating Print Function
print([],0).
print([H|T],C):-
	C1 is C-1,
	write(H),
	print(T,C1).

%Function to Append Lists
append1(A,X,[],X,A).
append1(A,X,Y,Z,B):-
	memberfunc(Y,X,G,_),
	(G==0,
	append(X,[Y],Z),
	append(A,[Y],B)),!;
	Z=X,
	B=A.

%Creating Membership Relation
memberfunc(_,[],G,X):-
	X=[],
	G=0.
memberfunc(H, [H1|T1],G,X):-
	(H==H1,
	G=1,
	X=T1),!;
	memberfunc(H,T1, G,X),!.

% Compares all the pairs of elements one by one with all the input pairs
% one by one and finds the new pair of elements for the transitive
% closure and updates in G2.

def(_,[],G2,G2).
def(R, [H|T],G1,G2):-
	find(R,[H|T],G1,G3),
	memberfunc(H,G3,_,X),
	def(G3,X,G3,G2),!.

% Compares 1 pair of element stored in H with all the input pairs one by
% one and finds the new pair of elements for the transitive closure and
% updates in G3.

find([],_,G2,G2).
find([H1|T1], [H|T], G1, G2):-
	trans(H,H1,X),
	append1(T1,G1,X,G4,T3),
	transitive(H,H1,Z),
	append1(T3, G4, Z, G3, T2),
	find(T2, [H|T], G3, G2),!.


















