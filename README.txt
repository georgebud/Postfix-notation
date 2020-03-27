Programul efectueaza evaluarea unei expresii aritmetice in forma postfixata si apoi afiseaza rezultatul.
Se foloseste ca input un string in care se afla expresia postfixata. Aceasta se citeste de la tastatura folosind macro-ul GET_STRING.
Operatiile care se aplica numerelor din expresie sunt: +, -, /, *, numerele fiind intregi.

Pentru efectuarea operatiilor am definit o serie de functii: division (efectueaza impartirea a doua numere), multiplication (efectueaza inmultirea a doua numere), sum (efectueaza adunarea a doua numere), difference (efectueaza scaderea a doua numere). Pentru fiecare operatie in parte se scot 2 operanzi de pe stiva, se efectueaza calculele si se adauga pe stiva rezultatul.
In functia 'parsing' se parcurge sirul caracter cu caracter (folosesc registrul ebx pe post de contor) si se verifica daca elementul curent este un operand sau un operator.
Functia 'number' este echivalentul functiei 'atoi', care formeaza numarul din caractere. Un numar este adaugat pe stiva atunci cand urmatorul caracter este spatiu.
Functia 'choice' intervine atunci cand caracterul curent este '-' si trebuie verificat daca acesta functioneaza ca un operator, facand in acest caz jump catre label-ul difference, sau daca este semnul unui numar, astfel facand salt catre label-ul number, urmand ca inainte de adaugarea pe stiva sa se inmulteasca rezultatul cu -1 (pentru aceasta ma folosesc de registrul edx).

Ultimul pop efectuat asupra stivei va contine rezultatul expresiei postfixate si va fi afisat.