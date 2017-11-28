/*   NAME - VIDIT JAIN  , ID - 2016A7PS0064P
 *   NAME - PIYUSH GARG , ID - 2016A7PS0035P  */
/*   PLEASE REFER TO THE README FILE FOE THE INPUT  */


trans([X,Y],[Y,X],[X,X]).	%If 2 transitive closure pairs can be formed, trans returns the second possible pair
trans([_,_],[_,_],[]).
transitive([W,X],[Y,Z],[]):-
	X=\=Y,
	W=\=Z,!.
transitive([Y,X],[Z,Y],[Z,X]).	%returns the transitive closure of 2 pairs if it exists, else []
transitive([X,Y],[Y,Z],[X,Z]).

%Checking Transitive Relation
checkTransitive(S,R):-
	iter1(S,R,R).

% Checks all the pairs of elements one by one with all the input pairs
% if their transitive closure is already in Relation or doesn't exist  

iter1(_,_,[]).
iter1(S, R, [H|T]):-
	iter2(R,H,R),
	[X,Y]=H,
	memberfunc(X,S,1,_),	%checks if every pair has elements 
	memberfunc(Y,S,1,_),	%from set S
	iter1(S,R,T),!.

% Compares 1 pair of element stored in H with all the input pairs in R
% and returns false if their transitive pair is not in R

iter2([],_,_).
iter2([H1|T1], H,R):-
	transitive(H,H1,Z),
	(Z==[];memberfunc(Z,R,1,_)),
	iter2(T1, H, R),!.


%Finding Transitive Closure
closure(S,R):-
	find1(S,R, R, R, G1),
	write("Transitive Closure="),
	write(G1).

%Function to Append Lists
append1(A,X,[],X,A).
append1(A,X,Y,Z,B):-
	memberfunc(Y,X,G,_),
	(G==0,
	append(X,[Y],Z),
	append(A,[Y],B)),!;
	Z=X,
	B=A.

%Membership Relation
%checks if H a member of [H1|T1]
%if yes, returns G=1 and the remaining tail as X, if no, returns G=0 and X=[]
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
% closure

find1(_,_,[],G2,G2).
find1(S,R, [H|T],G1,G2):-
	[X,Y]=H,
	memberfunc(X,S,1,_),
	memberfunc(Y,S,1,_),
	find2(R,[H|T],G1,G3),
	memberfunc(H,G3,_,Z),
	find1(S,G3,Z,G3,G2),!.

% Compares 1 pair of element stored in H with all the input pairs one by
% one and finds the new pair of elements for the transitive closure

find2([],_,G2,G2).
find2([H1|T1], [H|T], G1, G2):-
	trans(H,H1,X),
	append1(T1,G1,X,G4,T3),
	transitive(H,H1,Z),
	append1(T3, G4, Z, G3, T2),
	find2(T2, [H|T], G3, G2),!.

















