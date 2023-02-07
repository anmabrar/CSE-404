% Abu Naser Md Abrar(17101013)
% Date: 08/02/2023

% -------Gender-----------
male(abdullah).   female(sadika).
male(hamid).   female(rohima).
male(rahim).   female(aziza).
male(rafik).   female(sadia).
male(shafik).   female(keya).
male(alamin).   female(rimu).
male(shahid).   female(jasmin).
male(iqbal).   female(hasina).
male(sakib).   female(shifa).
male(rayhan).   female(nadia).
male(abrar).   female(anika).
male(hasib).   female(lota).
male(ayman).    female(mim).


% -------Declare Facts------

% --------- 6th gen -------
father(purno, anu).
mother(pihu, anu).

% ---------- 5th gen-------
father(rayhan, mim).
mother(nadia, mim).

% ---------- 4th gen--------
father(sakib, nadia).
mother(shifa, nadia).
father(sakib, abantika).
mother(shifa, abantika).
father(iqbal, abrar).
mother(hasina, abrar).
father(iqbal, anika).
mother(hasina, anika).
father(shahid, ayman).
mother(jasmin, ayman).
father(alamin, hasib).
mother(rimu, hasib).
father(alamin, lota).
mother(rimu, lota).

% ---------- 3rd gen-------
father(shafik, alamin).
mother(keya, alamin).
father(shafik, shahid).
mother(keya, shahid).
father(shafik, iqbal).
mother(keya, iqbal).
father(rafik, sakib).
mother(sadia, sakib).

% -------- 2nd gen--------
father(hamid, shafik).
mother(rohima, shafik).
father(rahim, sadia).
mother(aziza, sadia).


% ------- 1st gen -------
father(abdullah, rohima).
mother(sadika, rohima).
father(abdullah, rahim).
mother(sadika, rahim).

% -------Declare Rules-----

same(X,Y):- X=Y.
child(X,Y):- parent(Y,X).

parent(X,Y):-
    father(X,Y); mother(X,Y).  % X is parent of Y if X is father/mother of Y/

sibling(X,Y):-
    father(Z,X), father(Z,Y), not(same(X,Y)).
    % 'X-Y sibling if Z is parent of both X-Y and X-Y is not the same person.'

cousin(X,Y):-
    grandfather(A,X), grandfather(A,Y), not(sibling(X,Y)), not(same(X,Y)).
    % 'X is cousin of Y if parents of X & Y s are sibling.'

grandfather(X, Y):-
    parent(Z,Y), parent(X,Z), male(X).
    % 'X is grandfather of Y if Z is parent of Y and X is parent of Z'

grandparent(X,Y):-
    parent(Z,Y), parent(X,Z).
    % 'X is grandparent of Y if Z is parent of Y and X is parent of Z'

great_grandparent(X,Y):-
    parent(Z,Y), grandparent(X,Z).
    % 'X is great grandparent of Y if Z is parent of Y and X is grandparent of Z' 

great_great_grandparent(X,Y):-
    parent(Z,Y), great_grandparent(X,Z).
    % 'X is great great grandparent of Y if Z is gparent of Y and X is great grandparent of Z' 

great_grandfather(X,Y):-
    parent(Z,Y), grandfather(X,Z), male(X).
    % 'X is great-grandfather of Y if parent of Y s grandfather is X'.
    
great_great_grandfather(X,Y):-
    parent(Z,Y), great_grandfather(X, Z), male(X).
    % 'parent of Y s great grandparent is X.'

% ------ 2nd/3rd cousin ---------
secondCousin(X,Y):-
    great_grandfather(Z,X),  great_grandfather(Z,Y),
    grandfather(A,X),        not(grandfather(A,Y)),
    not(sibling(X,Y)),      not(cousin(X,Y)),
    not(same(X,Y)).
    % 'Great grandparents of X & Y are same but X & Y are not Sibling or Cousin or not same person.'

thirdCousin(X,Y):-
    great_great_grandfather(Z,X),    great_great_grandfather(Z,Y),
    great_grandfather(A,X),          not(great_grandfather(A,Y)),
    not(sibling(X,Y)), not(cousin(X,Y)), not(same(X,Y)).
    % 'great great grandparent of X & Y are same and X-Y are not sibling/cousin.'


% ---------- 1st cousin removed --------------
fcor(X,Y):-     % 'fcor - First Cousin Once Removed'
    parent(Z,X), cousin(Z,Y).
    % 'parent of X (Z) and Y are cousins.'

fctr(X,Y):-     % 'fctr - first cousin twice removed'
    grandparent(Z,X), cousin(Z,Y). 
    % 'grandparent of X(Z) are cousins'.

fcthr(X, Y):-   % 'fcthr - First Cousin 3rd removed'\
    great_grandparent(Z,X), cousin(Z,Y).
    % 'great grandparent of X(Z) are cousins'.

fcfr(X, Y):-    % 'first Cousin 4th removed'.
    great_great_grandparent(Z,X), cousin(Z,Y).
    % 'great great grandparent of X(Z) are cousins'.


% ------------  2nd Cousin removed --------------
scor(X,Y):-     % '2nd Cousin First removed'
    secondCousin(Z,Y), parent(Z,X).
    % 'parent of X(Z) are  2nd cousins.'

sctr(X,Y):-     % '2nd Cousin 2nd Removed'
    secondCousin(Z,Y), grandparent(Z,X).
    % 'grandparent of X(Z) are  2nd cousins.'

scthr(X, Y):-   % '2nd Cousin 3rd removed'.
    secondCousin(Z,Y), great_grandparent(Z,X).
    % 'great grandparent of X(Z) are  2nd cousins.'

scfr(X, Y):-   % '2nd cousin 4th removed.'
    secondCousin(Z,Y), great_great_grandparent(Z, X).
    % 'great great grandparent of X(Z) are  2nd cousins.'


%------------  3rd Cousin removed --------------
tcor(X,Y):-     % '3rd Cousin First removed'
    thirdCousin(Z,Y), parent(Z,X).
    % 'parent of X(Z) are  2nd cousins.'

tctr(X,Y):-     % '3rd Cousin 2nd Removed'
    thirdCousin(Z,Y), grandparent(Z,X).
    % 'grandparent of X(Z) are  2nd cousins.'

tcthr(X, Y):-   % '3rd Cousin 3rd removed'.
    thirdCousin(Z,Y), great_grandparent(Z,X).
    % 'great grandparent of X(Z) are  2nd cousins.'

tcfr(X, Y):-   % '3rd cousin 4th removed.'
    thirdCousin(Z,Y), great_great_grandparent(Z, X).
    % 'great great grandparent of X(Z) are  2nd cousins.'