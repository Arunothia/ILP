% % -------------------------------------------------------------------------------------------------------
% Trying to figure out the rules for :- zero positions on a krk end game chess
% % -------------------------------------------------------------------------------------------------------

:- set(h,1000)?
:- set(r,1000)?
:- set(inflate,99)?
:- set(nodes,100)?

:- observable(zero/1)?


% ---------------------------------------------------------------------------------------------------------
% % Mode Declarations
% --------------------------------------------------------------------------------------------------------- 

% ---------------------------------------------------------------------------------------------------------
% % Mode Declarations
% --------------------------------------------------------------------------------------------------------- 

:- modeh(1,zero(+pos_list))?
%:- modeb(1,wr_e_bk(+pos_list,#yes_no))?
%:- modeb(1,bk_corner(+pos_list,#yes_no))?
:- modeb('*',check_mate(+pos_list, #coin_distance, #e_distance, #coin_distance,#coin_distance,#e_distance,#yes_no,#coin_distance,#yes_no))?
%:- modeb(1,e_wk_dist(+pos_list,+e_distance))?
%:- modeb(1,e_wr_dist(+pos_list,#e_distance))?
%:- modeb(1,e_bk_dist(+pos_list,#e_distance))?
%:- modeb(1,max_wkbk_dist(+pos_list,#coin_distance))?
%:- modeb(1,min_wkbk_dist(+pos_list,#coin_distance))?
%:- modeb(1,max_wkwr_dist(+pos_list,+coin_distance))?
%:- modeb(1,min_wkwr_dist(+pos_list,#coin_distance))?
%:- modeb(1,max_wrbk_dist(+pos_list,#coin_distance))?
%:- modeb(1,min_wrbk_dist(+pos_list,#coin_distance))?
%:- modeb(1,rook(+pos_list,#yes_no))?

% ---------------------------------------------------------------------------------------------------------
% % Background Knowledge
% ---------------------------------------------------------------------------------------------------------

% Declaring valid files

file(a).  value_file(a,1). 
file(b).  value_file(b,2).
file(c).  value_file(c,3).
file(d).  value_file(d,4).
file(e).  value_file(e,5).
file(f).  value_file(f,6).
file(g).  value_file(g,7).
file(h).  value_file(h,8).

% Declaring valid ranks

rank(1). 
rank(2).
rank(3). 
rank(4).
rank(5). 
rank(6).
rank(7). 
rank(8).

% Defining pos_list

pos_list([A,B,C,D,E,F]) :-  file(A),rank(B), file(C),rank(D), file(E),rank(F).

% Valid Edge Distances

e_distance(0).
e_distance(1).
e_distance(2).
e_distance(3).
e_distance(4).

% Valid distances between coins

coin_distance(0).
coin_distance(1).
coin_distance(2).
coin_distance(3).
coin_distance(4).
coin_distance(5).
coin_distance(6).
coin_distance(7).

% Valid yes_no

yes_no(0).
yes_no(1).

% Defining min function that returns minimum of the list

min([X],F) :- F is X.
min([X|Tail],F) :- min(Tail,F1), X<F1, F is X.
min([X|Tail],F) :- min(Tail,F1), X>=F1, F is F1. 

% Defining max function that returns maximum of the list

max([X],F) :- F is X.
max([X|Tail],F) :- max(Tail,F1), X>=F1, F is X.
max([X|Tail],F) :- max(Tail,F1), X<F1, F is F1.    


% Defining abs function that returns absolute value

abs(A,F) :- A>=0, F is A.
abs(A,F) :- A<0, F is -A.

% Defining Distance from edge for white king

e_wk_dist([a,R,C,D,E,F],0) :- pos_list([a,R,C,D,E,F]).
e_wk_dist([h,R,C,D,E,F],0) :- pos_list([h,R,C,D,E,F]).
e_wk_dist([A,1,C,D,E,F],0) :- pos_list([A,1,C,D,E,F]).
e_wk_dist([A,8,C,D,E,F],0) :- pos_list([A,8,C,D,E,F]).

e_wk_dist([A,B,C,D,E,F],M) :- pos_list([A,B,C,D,E,F]),value_file(A,V), P is V-1, Q is 8-V, R is B-1, S is 8-B, min([P,Q,R,S],M), e_distance(M).  

% Defining Distance from edge for white rook

e_wr_dist([A,B,a,R,C,D],0) :- pos_list([A,B,a,R,C,D]).
e_wr_dist([A,B,h,R,C,D],0) :- pos_list([A,B,h,R,C,D]).
e_wr_dist([A,B,F,1,C,D],0) :- pos_list([A,B,F,1,C,D]).
e_wr_dist([A,B,F,8,C,D],0) :- pos_list([A,B,F,8,C,D]).

e_wr_dist([A,B,C,D,E,F],M) :- pos_list([A,B,C,D,E,F]),value_file(C,V), P is V-1, Q is 8-V, R is D-1, S is 8-D, min([P,Q,R,S],M), e_distance(M).  

% Defining Distance from edge for black king

e_bk_dist([A,B,C,D,a,R],0) :- pos_list([A,B,C,D,a,R]).
e_bk_dist([A,B,C,D,h,R],0) :- pos_list([A,B,C,D,h,R]).
e_bk_dist([A,B,C,D,F,1],0) :- pos_list([A,B,C,D,F,1]).
e_bk_dist([A,B,C,D,F,8],0) :- pos_list([A,B,C,D,F,8]).

e_bk_dist([A,B,C,D,E,F],M) :- pos_list([A,B,C,D,E,F]),value_file(E,V), P is V-1, Q is 8-V, R is F-1, S is 8-F, min([P,Q,R,S],M), e_distance(M).  

% Defining Maximum([rank,file]) Distance between the two kings

max_wkbk_dist([A,B,C,D,E,F],M) :- pos_list([A,B,C,D,E,F]), value_file(A,R), value_file(E,S), F1 is R-S, F2 is B-F, abs(F1,V), abs(F2,U), max([V,U],M), coin_distance(M).

% Defining Minimum([rank,file]) Distance between the two kings

min_wkbk_dist([A,B,C,D,E,F],M) :- pos_list([A,B,C,D,E,F]), value_file(A,R), value_file(E,S), F1 is R-S, F2 is B-F, abs(F1,V), abs(F2,U), min([V,U],M), coin_distance(M).

% Defining Maximum([rank,file]) Distance between white king and white rook

max_wkwr_dist([A,B,C,D,E,F],M) :- pos_list([A,B,C,D,E,F]), value_file(A,R), value_file(C,S), F1 is R-S, F2 is B-D, abs(F1,V), abs(F2,U), max([V,U],M), coin_distance(M).

% Defining Minimum([rank,file]) Distance between white king and white rook

min_wkwr_dist([A,B,C,D,E,F],M) :- pos_list([A,B,C,D,E,F]), value_file(A,R), value_file(C,S), F1 is R-S, F2 is B-D, abs(F1,V), abs(F2,U), min([V,U],M), coin_distance(M).

% Defining Maximum([rank,file]) Distance between white rook and black king

max_wrbk_dist([A,B,C,D,E,F],M) :- pos_list([A,B,C,D,E,F]), value_file(C,R), value_file(E,S), F1 is R-S, F2 is D-F, abs(F1,V), abs(F2,U), max([V,U],M), coin_distance(M).

% Defining Minimum([rank,file]) Distance between white rook and black king

min_wrbk_dist([A,B,C,D,E,F],M) :- pos_list([A,B,C,D,E,F]), value_file(C,R), value_file(E,S), F1 is R-S, F2 is D-F, abs(F1,V), abs(F2,U), min([V,U],M), coin_distance(M).

% Defining corners

corner(a,1).
corner(a,8).
corner(h,1).
corner(h,8). 

% Gives least value among ([A,B,C,D,E,F])

least([A,B,C,D,E,F],M) :- pos_list([A,B,C,D,E,F]),value_file(A,R), value_file(C,S), value_file(E,T), min([R,S,T,B,D,F],M).

% White Rook and Black King on same edge?

wr_e_bk([A,B,a,D,a,F],1) :- pos_list([A,B,a,D,a,F]).
wr_e_bk([A,B,h,D,h,F],1) :- pos_list([A,B,h,D,h,F]).  
wr_e_bk([A,B,C,1,E,1],1) :- pos_list([A,B,C,1,E,1]).  
wr_e_bk([A,B,C,8,E,8],1) :- pos_list([A,B,C,8,E,8]).    

% Is the black king on a corner?

bk_corner([A,B,C,D,E,F],1) :- pos_list([A,B,C,D,E,F]), corner(E,F).
bk_corner([A,B,C,D,E,F],0) :- pos_list([A,B,C,D,E,F]), not(corner(E,F)).

% Check_mate conditions

check_mate([A,B,C,D,E,F],P,Q,R,S,T,U,V,W) :-  min_wrbk_dist([A,B,C,D,E,F],P), e_bk_dist([A,B,C,D,E,F],Q), max_wkbk_dist([A,B,C,D,E,F],R),min_wkwr_dist([A,B,C,D,E,F],S), e_wr_dist([A,B,C,D,E,F],T), wr_e_bk([A,B,C,D,E,F],U),min_wkbk_dist([A,B,C,D,E,F],V),bk_corner([A,B,C,D,E,F],W).

% ---------------------------------------------------------------------------------------------------------
% Positive examples
% ---------------------------------------------------------------------------------------------------------

zero([c,1,a,3,a,1]).
zero([c,1,a,4,a,1]).
zero([c,1,a,5,a,1]).
zero([c,1,a,6,a,1]).
zero([c,1,a,7,a,1]).
zero([c,1,a,8,a,1]).
zero([c,2,a,3,a,1]).
zero([c,2,a,4,a,1]).
zero([c,2,a,4,a,2]).
zero([c,2,a,5,a,1]).
zero([c,2,a,5,a,2]).
zero([c,2,a,6,a,1]).
zero([c,2,a,6,a,2]).
zero([c,2,a,7,a,1]).
zero([c,2,a,7,a,2]).
zero([c,2,a,8,a,1]).
zero([c,2,a,8,a,2]).
zero([c,3,a,1,c,1]).
zero([c,3,e,1,c,1]).
zero([c,3,f,1,c,1]).
zero([c,3,g,1,c,1]).
zero([c,3,h,1,c,1]).
zero([d,3,a,1,d,1]).
zero([d,3,b,1,d,1]).
zero([d,3,f,1,d,1]).
zero([d,3,g,1,d,1]).
zero([d,3,h,1,d,1]).

% ---------------------------------------------------------------------------------------------------------
% Negative examples
% ---------------------------------------------------------------------------------------------------------

% From 16 :

:- zero([b,1,c,2,f,3]).
:- zero([a,1,h,6,e,4]).
:- zero([a,1,f,8,f,5]).
:- zero([a,1,g,3,f,6]).
:- zero([a,1,f,2,d,4]).
:- zero([a,1,g,2,g,4]).
:- zero([a,1,g,8,f,3]).
:- zero([a,1,h,7,f,4]).
:- zero([a,1,d,6,e,3]).
:- zero([a,1,d,2,f,3]).
:- zero([a,1,g,6,e,5]).
:- zero([b,1,d,7,d,5]).
:- zero([a,1,g,6,f,4]).
:- zero([b,1,c,7,e,7]).
:- zero([a,1,f,6,d,4]).
:- zero([a,1,h,8,f,6]).
:- zero([a,1,h,6,f,5]).
:- zero([a,1,f,4,f,6]).
:- zero([b,1,d,6,f,5]).
:- zero([a,1,d,2,f,4]).

% From 15 :

:- zero([a,1,c,5,f,5]).
:- zero([d,1,f,8,c,6]).
:- zero([c,1,d,6,d,3]).
:- zero([d,1,c,1,d,6]).
:- zero([c,1,f,8,e,5]).
:- zero([b,1,d,1,e,3]).
:- zero([b,2,c,7,f,4]).
:- zero([b,2,f,6,f,3]).
:- zero([a,1,e,5,g,4]).
:- zero([a,1,a,7,h,6]).
:- zero([b,1,h,6,d,6]).
:- zero([b,1,h,3,h,5]).
:- zero([c,1,f,7,f,4]).
:- zero([c,1,d,1,f,4]).
:- zero([b,1,a,6,e,6]).
:- zero([d,1,d,6,f,6]).
:- zero([c,1,d,4,e,6]).
:- zero([a,1,e,5,g,5]).
:- zero([b,2,f,8,d,3]).
:- zero([b,1,a,3,b,5]).


% From 12 :

:- zero([a,1,d,4,f,3]).
:- zero([c,2,d,5,h,8]).
:- zero([d,1,e,2,h,8]).
:- zero([d,3,a,1,f,6]).
:- zero([d,1,e,3,f,5]).
:- zero([d,3,h,8,e,6]).
:- zero([c,3,b,7,h,7]).
:- zero([d,3,c,2,e,6]).
:- zero([c,3,e,8,g,6]).
:- zero([d,3,b,1,f,5]).
:- zero([b,1,b,7,f,2]).
:- zero([c,1,g,1,a,2]).
:- zero([b,1,e,4,e,1]).
:- zero([d,3,b,6,d,6]).
:- zero([d,1,a,4,a,7]).
:- zero([d,4,f,3,f,5]).
:- zero([c,2,b,6,g,3]).
:- zero([b,1,e,2,b,8]).
:- zero([c,2,e,5,g,5]).
:- zero([b,1,g,7,g,1]).

% From 13 :

:- zero([b,1,f,2,h,4]).
:- zero([b,2,e,2,f,6]).
:- zero([b,1,e,2,d,5]).
:- zero([c,1,a,5,g,6]).
:- zero([c,1,c,8,h,6]).
:- zero([d,2,b,6,g,4]).
:- zero([c,2,g,3,e,7]).
:- zero([d,2,h,7,d,4]).
:- zero([c,2,d,3,d,7]).
:- zero([c,3,h,3,g,5]).
:- zero([d,2,b,4,d,7]).
:- zero([c,2,c,1,g,8]).
:- zero([b,1,d,8,g,2]).
:- zero([c,1,e,8,g,6]).
:- zero([b,1,b,5,f,8]).
:- zero([c,2,f,4,d,8]).
:- zero([b,1,g,6,b,7]).
:- zero([c,1,d,6,f,8]).
:- zero([c,2,b,2,e,8]).
:- zero([d,1,a,5,f,8]).

% From 14 :

:- zero([d,1,g,4,b,7]).
:- zero([d,1,a,2,f,6]).
:- zero([d,1,c,4,c,8]).
:- zero([b,2,a,1,e,5]).
:- zero([c,1,h,2,c,6]).
:- zero([c,1,e,3,c,6]).
:- zero([c,1,g,7,g,2]).
:- zero([b,2,d,7,e,2]).
:- zero([b,2,a,3,d,3]).
:- zero([d,1,b,3,d,6]).
:- zero([c,1,h,5,f,5]).
:- zero([c,1,c,5,e,3]).
:- zero([a,1,c,5,e,1]).
:- zero([b,2,d,8,d,3]).
:- zero([c,1,f,4,d,8]).
:- zero([d,1,g,6,b,4]).
:- zero([a,1,e,8,h,6]).
:- zero([d,1,g,8,g,5]).
:- zero([b,1,f,4,b,4]).
:- zero([b,2,g,1,f,3]).

% From Draw :

:- zero([a,1,e,4,d,4]).
:- zero([b,2,h,7,h,6]).
:- zero([c,1,d,6,e,6]).
:- zero([b,1,c,8,b,8]).
:- zero([d,1,b,3,a,3]).
:- zero([c,1,e,2,a,1]).
:- zero([c,3,g,7,h,6]).
:- zero([d,2,e,8,f,7]).
:- zero([c,3,g,1,h,2]).
:- zero([b,2,f,6,f,5]).
:- zero([d,2,f,7,g,7]).
:- zero([d,3,c,6,c,5]).
:- zero([c,2,f,7,e,7]).
:- zero([d,3,d,6,c,5]).
:- zero([b,1,g,5,h,5]).
:- zero([d,1,c,6,d,6]).
:- zero([b,2,h,8,g,7]).
:- zero([d,3,d,7,c,7]).
:- zero([d,1,e,5,d,6]).
:- zero([c,1,g,2,h,3]).
:- zero([b,1,b,6,a,6]).
:- zero([d,1,b,2,a,3]).
:- zero([d,2,b,5,b,4]).
:- zero([d,2,a,8,b,7]).
:- zero([d,4,g,2,f,1]).
:- zero([d,2,b,8,c,8]).
:- zero([d,1,h,7,g,6]).
:- zero([c,1,h,8,g,8]).
:- zero([c,1,c,5,b,5]).
:- zero([c,2,g,8,h,7]).
:- zero([c,1,e,8,f,8]).
:- zero([a,1,e,2,f,2]).
:- zero([c,2,d,8,c,7]).
:- zero([b,1,a,6,b,5]).
:- zero([a,1,g,1,h,1]).
:- zero([c,2,d,5,e,5]).
:- zero([d,4,c,2,c,1]).
:- zero([d,1,g,5,h,5]).
:- zero([c,3,f,4,e,3]).
:- zero([d,2,c,5,d,5]).
:- zero([b,1,e,3,f,2]).
:- zero([c,3,h,3,g,4]).
:- zero([d,2,c,7,b,8]).
:- zero([d,4,f,4,g,5]).
:- zero([d,3,e,5,f,5]).
:- zero([c,1,g,5,g,6]).
:- zero([a,1,e,5,e,4]).
:- zero([b,2,e,1,e,2]).
:- zero([c,3,g,5,h,4]).
:- zero([c,2,b,5,b,4]).
:- zero([c,2,d,6,e,5]).
:- zero([c,1,h,3,h,4]).
:- zero([c,1,a,6,b,5]).
:- zero([c,2,f,4,e,4]).
:- zero([b,2,e,2,f,2]).
:- zero([c,3,h,6,g,6]).
:- zero([c,3,h,8,h,7]).
:- zero([d,3,a,2,a,1]).
:- zero([d,4,f,2,e,1]).
:- zero([d,3,d,8,c,8]).
:- zero([c,3,h,5,g,5]).
:- zero([d,1,c,5,b,6]).
:- zero([b,1,f,6,e,6]).
:- zero([d,3,g,6,f,7]).
:- zero([c,2,c,6,d,6]).
:- zero([d,2,b,4,c,5]).
:- zero([d,2,e,5,f,4]).
:- zero([b,1,f,6,e,5]).
:- zero([c,1,b,5,a,5]).
:- zero([b,1,f,8,e,8]).
:- zero([c,1,d,3,e,4]).
:- zero([c,1,b,7,c,8]).
:- zero([c,3,g,2,h,2]).
:- zero([d,2,a,5,b,6]).
:- zero([d,3,h,3,h,4]).
:- zero([d,2,d,5,c,6]).
:- zero([c,1,b,7,a,7]).
:- zero([d,2,c,7,c,8]).
:- zero([d,1,g,4,f,4]).
:- zero([d,3,d,6,d,5]).
:- zero([b,1,h,3,g,2]).
:- zero([c,2,e,4,d,4]).
:- zero([b,1,d,3,e,4]).
:- zero([d,1,b,5,a,5]).
:- zero([d,3,f,7,e,7]).
:- zero([d,3,h,8,g,7]).
:- zero([d,3,h,1,g,1]).
:- zero([a,1,c,1,c,2]).
:- zero([b,2,f,5,g,4]).
:- zero([a,1,g,5,f,5]).
:- zero([b,1,b,5,a,4]).
:- zero([a,1,b,3,c,2]).
:- zero([b,1,g,3,h,2]).
:- zero([d,2,e,5,e,6]).
:- zero([c,2,d,5,c,6]).
:- zero([b,1,g,2,f,1]).
:- zero([d,1,b,1,a,1]).
:- zero([d,1,b,8,b,7]).
:- zero([c,1,d,4,c,3]).
:- zero([d,1,e,3,e,4]).
:- zero([c,1,h,1,h,2]).
:- zero([c,1,g,5,f,6]).
:- zero([c,2,h,8,h,7]).
:- zero([c,3,g,6,h,5]).
:- zero([b,1,g,8,h,8]).
:- zero([c,1,c,4,d,3]).
:- zero([d,1,b,1,b,2]).
:- zero([c,2,c,8,d,7]).
:- zero([c,2,h,8,g,7]).
:- zero([d,4,g,7,h,8]).
:- zero([d,4,g,5,h,4]).
:- zero([d,1,e,4,e,5]).
:- zero([c,1,d,2,a,1]).
:- zero([c,2,d,6,e,7]).
:- zero([d,1,g,8,h,7]).
:- zero([c,3,f,3,e,3]).
:- zero([b,2,h,5,g,6]).
:- zero([d,3,f,5,e,5]).
:- zero([b,1,g,3,g,2]).
:- zero([c,3,g,8,h,7]).
:- zero([b,1,a,7,a,8]).
:- zero([d,1,e,5,d,5]).
:- zero([d,2,g,6,g,7]).
:- zero([c,3,e,1,f,1]).
:- zero([c,3,g,3,h,3]).
:- zero([b,1,h,5,h,6]).
:- zero([c,2,b,5,c,4]).
:- zero([b,1,d,4,e,5]).
:- zero([d,2,a,2,b,1]).
:- zero([c,1,g,8,h,8]).
:- zero([d,1,b,7,a,6]).
:- zero([d,3,g,4,g,3]).
:- zero([d,2,e,4,e,5]).
:- zero([c,1,f,4,g,4]).
:- zero([a,1,e,3,e,2]).
:- zero([d,2,f,1,f,2]).
:- zero([c,2,g,1,f,2]).
:- zero([d,3,d,5,d,6]).
:- zero([a,1,f,5,f,6]).
:- zero([c,2,b,6,b,7]).
:- zero([a,1,g,4,f,3]).
:- zero([a,1,f,2,e,2]).
:- zero([d,2,h,4,h,3]).
:- zero([a,1,g,4,g,3]).
:- zero([d,2,a,6,b,6]).
:- zero([b,2,e,2,d,3]).
:- zero([c,1,e,7,e,6]).
:- zero([d,1,a,4,b,3]).
:- zero([d,2,g,6,f,6]).
:- zero([c,2,a,1,a,2]).
:- zero([d,2,e,7,d,7]).
:- zero([c,1,g,5,h,4]).
:- zero([d,1,f,1,g,2]).
:- zero([d,2,e,5,e,4]).
:- zero([d,4,h,1,g,1]).
:- zero([c,2,b,7,c,8]).
:- zero([d,3,g,4,f,5]).
:- zero([b,1,c,3,b,4]).
:- zero([b,1,c,4,b,3]).
:- zero([c,1,e,2,f,2]).
:- zero([b,1,d,5,d,4]).
:- zero([c,1,c,5,b,6]).
:- zero([a,1,g,2,f,3]).
:- zero([d,3,g,3,f,4]).
:- zero([b,2,e,2,d,2]).
:- zero([b,1,f,1,g,2]).
:- zero([d,1,e,6,e,5]).
:- zero([d,3,g,8,g,7]).
:- zero([d,3,h,8,h,7]).
:- zero([a,1,f,2,g,1]).
:- zero([c,3,f,4,f,5]).
:- zero([d,3,b,2,a,1]).
:- zero([d,3,d,8,d,7]).
:- zero([d,1,f,5,e,4]).
:- zero([b,2,e,3,f,4]).
:- zero([d,3,g,3,h,2]).
:- zero([c,1,f,8,e,7]).
:- zero([c,3,f,2,e,3]).
:- zero([d,3,g,2,g,1]).
:- zero([d,1,b,7,b,6]).
:- zero([c,2,f,4,f,5]).
:- zero([d,4,g,6,f,5]).
:- zero([d,2,g,8,g,7]).
:- zero([d,1,a,8,b,8]).
:- zero([b,1,e,1,d,1]).
:- zero([c,3,e,5,f,4]).
:- zero([c,2,d,6,d,7]).
:- zero([d,3,d,1,c,1]).
:- zero([d,2,a,7,a,6]).
:- zero([d,2,a,6,b,7]).
:- zero([c,2,f,2,g,3]).
:- zero([a,1,d,4,e,3]).
:- zero([c,1,g,2,f,3]).
:- zero([b,1,e,7,f,6]).
:- zero([c,2,g,3,h,2]).
:- zero([c,1,a,5,a,4]).
:- zero([b,1,c,3,d,3]).
:- zero([d,2,g,5,f,5]).
:- zero([c,3,g,1,f,1]).
:- zero([c,1,f,6,e,7]).
:- zero([d,2,a,1,b,1]).
:- zero([d,2,a,4,a,3]).
:- zero([b,1,f,1,f,2]).
:- zero([c,1,d,5,e,5]).
:- zero([c,1,b,5,c,4]).
:- zero([c,2,f,6,f,5]).
:- zero([a,1,h,4,h,5]).
:- zero([c,1,e,4,f,3]).
:- zero([b,1,d,4,e,4]).
:- zero([d,1,f,6,g,6]).
:- zero([a,1,g,3,f,4]).
:- zero([c,1,c,2,a,1]).
:- zero([c,2,b,6,a,5]).
:- zero([d,3,h,2,g,2]).
:- zero([a,1,d,4,c,3]).
:- zero([d,4,g,7,g,6]).
:- zero([b,2,f,7,g,6]).
:- zero([d,4,e,1,d,1]).
:- zero([c,1,b,3,c,3]).
:- zero([b,2,f,5,f,4]).
:- zero([c,1,h,7,g,7]).
:- zero([d,4,g,3,f,4]).
:- zero([c,1,b,7,b,6]).
:- zero([b,1,d,5,d,6]).
:- zero([c,1,f,4,f,3]).
:- zero([d,2,d,6,c,5]).
:- zero([c,2,b,4,c,4]).
:- zero([d,2,b,7,b,8]).
:- zero([d,3,e,6,f,7]).
:- zero([a,1,h,7,h,8]).
:- zero([d,3,d,6,e,7]).
:- zero([c,2,g,3,g,4]).
:- zero([d,2,e,6,f,6]).
:- zero([c,2,d,7,e,8]).
:- zero([d,2,a,5,a,4]).
:- zero([c,3,g,7,g,6]).
:- zero([d,1,g,1,h,2]).
:- zero([d,2,g,5,h,5]).
:- zero([d,4,f,1,f,2]).
:- zero([d,3,c,8,d,7]).
:- zero([c,2,a,8,b,7]).
:- zero([b,1,f,8,g,7]).
:- zero([d,3,h,6,h,5]).
:- zero([b,2,g,5,g,6]).
:- zero([d,1,h,6,g,7]).
:- zero([c,3,f,3,e,2]).
:- zero([d,1,f,3,e,4]).
:- zero([d,1,h,6,h,5]).
:- zero([d,2,c,6,d,6]).
:- zero([b,2,f,5,f,6]).
:- zero([c,1,f,5,f,4]).
:- zero([c,3,f,3,g,3]).
:- zero([d,1,g,5,h,4]).
:- zero([c,1,e,3,e,4]).
:- zero([b,2,e,4,e,5]).
:- zero([d,1,a,5,b,6]).
:- zero([d,3,g,2,h,3]).
:- zero([c,2,c,7,d,7]).
:- zero([c,2,g,2,h,2]).
:- zero([d,2,d,7,d,8]).
:- zero([d,2,b,5,c,4]).
:- zero([d,2,h,3,g,2]).
:- zero([c,1,a,6,a,5]).
:- zero([d,3,e,6,f,5]).
:- zero([d,4,g,2,h,3]).
:- zero([d,1,d,5,d,4]).
:- zero([c,3,e,2,e,1]).
:- zero([b,1,f,2,f,1]).
:- zero([c,1,b,4,c,5]).
:- zero([d,2,d,7,d,6]).
:- zero([c,3,e,2,e,3]).
:- zero([d,1,h,6,g,5]).
:- zero([c,2,h,3,g,3]).
:- zero([c,2,b,8,c,7]).
:- zero([d,2,g,8,h,7]).
:- zero([c,1,g,6,h,7]).
:- zero([b,1,b,7,a,6]).
:- zero([b,2,e,4,f,4]).
:- zero([b,1,e,8,e,7]).
:- zero([c,3,e,2,f,1]).
:- zero([d,1,g,3,f,4]).
:- zero([c,3,f,5,g,5]).
:- zero([c,1,d,6,d,5]).
:- zero([c,2,f,8,g,7]).
:- zero([d,3,e,7,f,6]).
:- zero([d,1,a,7,a,6]).
:- zero([c,2,f,6,f,7]).
:- zero([d,3,g,6,g,5]).
:- zero([d,1,g,6,f,5]).
:- zero([c,2,a,6,a,5]).
:- zero([c,3,g,3,g,2]).
:- zero([c,2,e,2,e,3]).
:- zero([c,2,c,8,b,7]).
:- zero([c,1,a,7,b,8]).
:- zero([c,2,g,7,h,6]).
:- zero([a,1,g,4,h,3]).
:- zero([b,1,f,5,e,6]).
:- zero([b,2,g,7,f,6]).
:- zero([c,1,c,5,c,4]).
:- zero([b,1,h,1,g,2]).
:- zero([b,1,c,6,d,7]).
:- zero([b,1,e,2,f,3]).
:- zero([c,1,g,6,h,6]).
:- zero([d,1,b,4,c,4]).
:- zero([c,1,g,2,g,3]).
:- zero([d,4,g,3,h,3]).
:- zero([c,2,c,7,d,8]).
:- zero([c,1,g,5,h,6]).
:- zero([b,2,g,3,g,2]).
:- zero([c,1,h,6,h,5]).
:- zero([d,1,d,8,c,8]).
:- zero([c,3,g,3,h,2]).
:- zero([d,3,g,6,h,5]).
:- zero([d,2,f,2,g,2]).
:- zero([c,1,g,6,f,7]).
:- zero([d,3,b,2,a,2]).
:- zero([c,1,e,6,d,7]).
:- zero([c,2,h,2,h,3]).
:- zero([c,1,e,4,e,5]).
:- zero([d,2,e,8,f,8]).
:- zero([b,2,e,1,f,2]).
:- zero([d,4,g,3,g,4]).
:- zero([d,3,b,4,b,3]).
:- zero([c,2,h,6,g,7]).
:- zero([c,2,d,7,c,6]).
:- zero([d,2,f,8,f,7]).
:- zero([a,1,d,3,c,3]).
:- zero([d,2,g,7,g,6]).
:- zero([c,1,e,1,f,1]).
:- zero([c,2,a,4,b,4]).
:- zero([c,2,b,2,a,1]).
:- zero([d,2,c,8,b,7]).
:- zero([d,4,c,2,d,1]).
:- zero([d,4,g,1,h,1]).
:- zero([c,1,h,6,g,6]).
:- zero([c,3,h,7,g,7]).
:- zero([c,2,a,3,a,2]).
:- zero([c,1,b,5,b,6]).
:- zero([a,1,e,3,d,3]).
:- zero([c,3,h,1,g,2]).
:- zero([d,3,b,6,a,6]).
:- zero([c,1,f,5,e,6]).
:- zero([b,2,g,7,g,6]).
:- zero([a,1,h,5,g,5]).
:- zero([d,3,c,6,d,7]).
:- zero([c,2,d,6,e,6]).
:- zero([b,2,h,7,g,7]).
:- zero([d,2,b,2,a,1]).
:- zero([d,3,b,1,a,2]).
:- zero([c,1,g,2,g,1]).
:- zero([b,1,b,7,b,8]).
:- zero([c,1,b,8,c,7]).
:- zero([d,1,e,6,f,6]).
:- zero([d,1,f,2,f,1]).
:- zero([b,2,g,4,f,4]).
:- zero([d,3,a,6,b,6]).
:- zero([c,2,f,1,e,1]).
:- zero([c,1,d,5,d,4]).
:- zero([d,2,h,2,g,1]).
:- zero([d,3,c,6,d,6]).
:- zero([c,2,b,8,a,8]).
:- zero([d,3,g,5,g,6]).
:- zero([c,1,g,7,f,6]).
:- zero([b,1,d,6,c,5]).
:- zero([d,4,f,3,g,4]).
:- zero([d,1,b,5,b,6]).
:- zero([d,1,f,7,g,8]).
:- zero([b,1,f,2,g,2]).
:- zero([c,2,f,5,f,6]).
:- zero([d,1,e,6,f,5]).
:- zero([b,2,f,4,e,3]).
:- zero([d,2,g,8,h,8]).
:- zero([c,1,c,4,b,5]).
:- zero([c,2,b,7,c,7]).
:- zero([d,1,c,8,b,8]).
:- zero([c,2,b,7,a,7]).
:- zero([d,3,g,6,f,6]).
:- zero([c,2,b,5,a,5]).
:- zero([b,2,e,3,d,4]).
:- zero([c,1,f,5,e,4]).
:- zero([d,3,a,5,b,6]).
:- zero([d,1,f,5,e,6]).
:- zero([c,2,e,7,e,6]).
:- zero([c,2,e,4,f,5]).
:- zero([c,2,c,5,c,4]).
:- zero([b,2,f,2,g,3]).
:- zero([c,2,e,7,f,6]).
:- zero([d,4,h,4,g,5]).
:- zero([c,3,h,1,g,1]).
:- zero([d,2,b,1,a,1]).
:- zero([d,3,d,7,d,8]).
:- zero([d,1,b,6,a,6]).
:- zero([c,1,f,2,a,1]).
:- zero([c,1,b,3,a,3]).
:- zero([d,4,f,2,g,3]).
:- zero([c,1,h,2,g,1]).
:- zero([c,1,c,8,d,8]).
:- zero([c,3,f,1,e,1]).
:- zero([d,4,f,2,f,1]).
:- zero([c,1,d,6,c,7]).
:- zero([c,2,e,8,e,7]).
:- zero([d,1,f,6,f,5]).
:- zero([d,2,g,4,f,3]).
:- zero([c,3,e,1,f,2]).
:- zero([d,3,b,1,a,1]).
:- zero([d,3,e,6,d,7]).
:- zero([d,3,h,6,g,5]).
:- zero([c,3,a,2,b,1]).
:- zero([b,2,g,3,f,3]).
:- zero([a,1,c,2,c,3]).
:- zero([b,1,f,3,g,4]).
:- zero([b,1,g,4,h,3]).
:- zero([d,1,f,7,g,6]).
:- zero([d,2,g,1,f,1]).
:- zero([d,2,f,7,e,7]).
:- zero([d,3,f,3,g,4]).
:- zero([b,1,b,7,c,8]).
:- zero([b,1,c,5,b,6]).
:- zero([b,1,b,5,a,6]).
:- zero([c,2,a,5,b,6]).
:- zero([b,1,c,8,d,7]).
:- zero([d,1,g,7,f,8]).
:- zero([d,1,h,3,g,2]).
:- zero([c,2,h,2,g,1]).
:- zero([b,1,c,6,b,5]).
:- zero([d,1,h,1,g,1]).
:- zero([d,1,b,1,a,2]).
:- zero([a,1,f,4,e,5]).
:- zero([c,2,b,4,a,3]).
:- zero([d,3,g,5,g,4]).
:- zero([c,2,c,8,d,8]).
:- zero([a,1,g,6,f,6]).
:- zero([b,2,d,2,e,1]).
:- zero([d,1,g,7,g,6]).
:- zero([d,3,a,7,a,6]).
:- zero([b,1,f,3,f,2]).
:- zero([a,1,d,3,c,2]).
:- zero([d,3,f,7,f,8]).
:- zero([c,1,c,4,b,4]).
:- zero([d,4,f,3,e,2]).
:- zero([d,3,g,5,h,6]).
:- zero([b,1,c,7,c,8]).
:- zero([c,1,h,6,g,5]).
:- zero([d,2,a,6,b,5]).
:- zero([d,1,f,4,f,5]).
:- zero([d,4,h,7,h,6]).
:- zero([d,4,g,4,h,4]).
:- zero([d,3,b,3,b,4]).
:- zero([c,1,h,5,g,5]).
:- zero([c,2,b,8,b,7]).
:- zero([b,1,d,2,e,3]).
:- zero([b,1,e,5,d,6]).
:- zero([d,1,f,3,g,4]).
:- zero([c,1,e,2,d,3]).
:- zero([d,2,c,6,d,5]).
:- zero([a,1,f,1,g,1]).
:- zero([c,1,a,4,b,4]).
:- zero([d,2,g,2,h,2]).
:- zero([c,1,a,5,b,5]).
:- zero([c,3,g,7,h,8]).
:- zero([d,4,h,1,g,2]).
:- zero([b,1,g,2,f,2]).
:- zero([b,1,b,7,a,7]).
:- zero([d,2,d,8,e,7]).
:- zero([c,2,d,4,d,5]).
:- zero([d,2,b,7,a,6]).
:- zero([a,1,d,4,e,4]).
:- zero([c,1,d,8,e,7]).
:- zero([d,3,c,6,c,7]).
:- zero([a,1,f,2,e,1]).
:- zero([b,1,a,6,b,6]).
:- zero([c,2,h,1,h,2]).
:- zero([d,1,f,2,g,3]).
:- zero([c,1,g,5,f,4]).
:- zero([b,1,e,6,d,7]).
:- zero([c,1,f,4,e,5]).
:- zero([d,2,h,5,g,6]).
:- zero([d,3,f,5,g,4]).
:- zero([c,3,g,2,f,2]).
:- zero([a,1,f,5,e,4]).
:- zero([d,3,e,5,f,4]).
:- zero([b,2,f,3,e,3]).
:- zero([b,2,g,5,h,5]).
:- zero([b,2,g,1,f,2]).
:- zero([c,2,c,6,c,5]).
:- zero([c,2,d,8,e,7]).
:- zero([d,1,f,8,g,8]).
:- zero([b,2,e,5,f,5]).
:- zero([d,4,f,3,g,3]).
:- zero([c,2,h,5,g,4]).
:- zero([c,2,g,4,h,4]).
:- zero([d,1,g,4,g,3]).
:- zero([b,2,f,5,g,5]).
:- zero([a,1,h,3,g,3]).
:- zero([d,2,a,3,b,4]).
:- zero([c,1,e,5,f,4]).
:- zero([d,3,h,4,g,4]).
:- zero([b,2,d,5,e,4]).
:- zero([d,4,f,3,g,2]).
:- zero([d,2,c,7,d,7]).



