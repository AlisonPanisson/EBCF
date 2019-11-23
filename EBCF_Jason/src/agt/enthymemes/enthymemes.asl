// module enthymemes in project Enthymemes

annot2remove([source(org), as(_)]).

enthymemetisation(Arg, Arg1, AS, Unifier):- .nth(0,Arg,defeasible_rule(Goal,Condition)[as(AS)]) & jia.get_unifier(defeasible_rule(Goal,Condition)[as(AS)],Unifier) & // .print("AS: ", AS, " Unifier: ", Unifier) &
						.findall(Y[S], (annot2remove(Remove) & .member(S,Remove) & .member(Y[S],Arg)), List) & //.print("Removing the Information: ", List) &
						delete(List,Arg,Arg1). // & .print("Enthymeme: " , Arg1).
					   	
decodification(Arg, AS, Unifier, ArgD):-  jia.decodification(AS,Unifier,defeasible_rule(C,S)[as(AS)]) & .add_nested_source(S, dec, SA) 
		& add_list(SA,Arg,Result) & .concat([defeasible_rule(C,S)[as(AS)]],Result,ArgD). // & .print("Final: ", ArgD).


add_list([], List, Result) :-  Result = List.
add_list([H[An]], List, Result) :-   not(.member(H,List)) & .concat([H[An]],List,Result).
add_list([H[An]], List, Result) :-  .member(H,List) & Result == List.
add_list([H[An]|T], List, Result) :-   not(.member(H,List)) & .concat([H[An]],List,ListTemp) & add_list(T, ListTemp, Result).
add_list([H[An]|T], List, Result) :-  .member(H,List) & add_list(T, List, Result).
			   
delete([H|T], List, Result):- .delete(H, List, List2) & delete(T, List2, Result).
delete([H], List, Result):- .delete(H, List, Result).