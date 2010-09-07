%{ open Grammaire %}

%token GAUCHE DROITE
 IO EOF
%token <string> MCLE

%start tableTransitions
%type <int> direction
%type <Grammaire.transition> transition
%type <Grammaire.transition list> listeTransitions
%type <Grammaire.transition list> tableTransitions

%%

direction:
	GAUCHE		{ -1 }
	| DROITE
		{ 1 }
	| IO		{ 0 }

transition:
	MCLE MCLE MCLE MCLE direction	{ {etatCourant = $1;
								symboleEntre = $2;
								etatSuivant = $3;
								symboleSortie = $4;
								actionEffectuee = $5} }
	
listeTransitions:
	listeTransitions transition	{ $2::$1 }
	| transition		{ [$1] }
	
tableTransitions:
	listeTransitions EOF	{ List.rev $1 }
