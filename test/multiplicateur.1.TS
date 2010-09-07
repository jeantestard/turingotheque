0,1

% ruban = 0 0 1 1 1 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0

%mettre l'oeil devant le premier 1
boucle {si (0) {D} ou {fin} }

%                                             0011100011111000
%                                               X
boucle {si (1) {D} ou {fin} }
boucle {D si (1) {fin } }
boucle {D si (0) { fin } }
%                                             0011100011111000
%                                                          X
D
1
%                                             0011100011111010
%                                                           X
G
boucle {G si (0) {fin } }
boucle {G si (1) {fin } }

boucle {
  0
  G
  si (1){
  D
  boucle { D si (1){ fin } }
  boucle { D si (0){ fin } }
  G
  boucle {
    0
    G
	si (1){
    D
    boucle { D si (1) {fin } }
    boucle { D si (0) {fin } }
    1
    boucle { G si (0) {fin } }
    boucle { G si (1) {fin } }
	}
	ou {fin}
	}
  D
  1
  boucle { D si (1) {fin } }
  G
  boucle {
		G
		si (0) {1}
		ou {fin}
		}
  boucle {G si (1) { fin } }
  }
  ou {fin}
}

boucle {D si (1) {fin } }
boucle {0 D si (0) {fin } }
D


#
