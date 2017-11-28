                                      #Transitive


Q1. Write a Prolog program for testing whether a given (binary) relation R (on a finite set S) is
transitive.

 INPUT FORMAT 
		(a) checkTransitive(S,R).
		
		where S is the finite set and R is the binary relation on set S
		example : checkTransitive([1,2,3],[[1,2],[1,3]]).
		
		Returns false if any pair has elements which are not in S


Q2. Add rules (or modify the program in Q1) to compute the transitive closure of a given relation.


 INPUT FORMAT
		(b) closure(S,R).

		where S is the finite set and R is the binary relation on set S
		example : closure([1,2,3],[[1,2],[1,3]]).

		Returns false if any pair has elements which are not in S

TRANSITIVE
		(c) transitive(X,Y,Z).
		Returns Z such that X,Y,Z forms a transitive relation

MEMBERFUNCTION
		(d) memberfunc(H, R,G,X).
		Returns G=1 if H a member of R and the X=list of elements after H in R, else G=0 and X=[]
