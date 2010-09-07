type symbole = string

type expression =
   Racine of expression list
| Si of symbole list * expression
| Alt of symbole list * expression * expression
| Boucle2 of symbole list * expression
| Boucle of expression
| Gauche
| Droite
| Ecriture of symbole
| Fin
| Programme of symbole list *  expression list

type programme =
	| Programme of symbole list *  expression list