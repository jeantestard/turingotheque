%{ open Grammaire %}

%token PARG PARD CRG CRD SEPARATEUR
%token SI OU BOUCLENEGATIVE BOUCLE2 BOUCLE GAUCHE DROITE
 ECRIS FIN EOF
%token <string> SYMBOLE

%start programme
%type <Grammaire.programme> programme

%nonassoc SI
%nonassoc OU

%%

expression:
 SI PARG listeSymboles PARD expression %prec SI { Si($3, $5) }
| SI PARG listeSymboles PARD expression OU expression { Alt($3, $5, $7) }
| BOUCLE2 PARG listeSymboles PARD expression { Boucle2($3, $5) }
| BOUCLE expression { Boucle($2) }
| GAUCHE { Gauche }
| DROITE { Droite }
| SYMBOLE { Ecriture($1) }
| FIN { Fin }
| CRG listeExpressions CRD { Racine(List.rev $2) }

listeExpressions:
{ [] }
| listeExpressions expression { $2 :: $1 }

listeSymboles:
 SYMBOLE { [$1] }
| listeSymboles SEPARATEUR SYMBOLE { $3 :: $1 }
programme:
listeSymboles listeExpressions EOF { Programme( $1, List.rev $2) }
