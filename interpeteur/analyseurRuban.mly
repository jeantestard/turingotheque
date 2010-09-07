%{ %}

%token EOF
%token <string> SYMBOLE

%start ruban
%type <string list> listeSymboles
%type <string list> ruban

%%

listeSymboles:
	listeSymboles SYMBOLE	{ $2::$1 }
	| SYMBOLE			{ [$1] }

ruban:
	listeSymboles EOF		{ List.rev $1 }
	| EOF				{ [] }
