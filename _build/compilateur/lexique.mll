{ open Analyseur }

rule token = parse
| "si" { SI }
| "ou" { OU }
| "boucle2" { BOUCLE2 }
| "boucle" { BOUCLE }
| "G" { GAUCHE }
| "D" { DROITE }
| "ecris" { ECRIS }
| "fin" { FIN }
| "ou" { OU }
| '(' { PARG }
| ')' { PARD }
| '{' { CRG }
| '}' { CRD }
| (('?')  | (['a'-'z''A'-'Z''0'-'9']+)) as lexeme { SYMBOLE(lexeme) }
| ',' { SEPARATEUR }
| [' ' '\t' '\r' '\n'] { token lexbuf }
| "%" { commentaire lexbuf }
| "#" { EOF }
| _ as char { raise (Failure("caractère non reconnu: " ^ Char.escaped char)) }

and commentaire = parse
"\n" { token lexbuf }
| _ { commentaire lexbuf }