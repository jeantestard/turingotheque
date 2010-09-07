0,1

boucle {D si (1) {fin}}


boucle {
  D
  D
  si (0) {fin }
}
G
G
G
boucle {
  si (1) {
  0
  G
	}
 ou {fin}
}

boucle {D si (1) {fin } }

#
% calcul du reste par 2
% nb : il faut laisser au moins deux cases libres à gauche de l'oeil
% le principe de l'algorithme est de mettre à 0 un bâton sur 2 puis de "serrer"
% les bâtons restants vers la gauche

%                          nombre pair        0011111110000
%                          nombre impair      0011111111000
%                                               X
boucle
  D
  D
%                          nombre pair        0011111110000
%                          nombre impair      0011111111000
%                                                   X
  si (0) fin }
}
%                          nombre pair        0011111110000
%                          nombre impair      0011111111000
%                                                       X

G
G
G
%                          nombre pair        0011111110000
%                          nombre impair      0011111111000
%                                                    X

boucle
  si (0) fin }
  0
  G
}
%                          nombre pair        0000000010000
%                          nombre impair      0000000011000
%                                              X
boucle D si (1) fin } }
%                          nombre pair        0000000010000
%                          nombre impair      0000000011000
%                                                     X

I
#




