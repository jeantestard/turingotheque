{ open AnalyseurTransitions }

rule token = parse
[' ' '\t' '\r' '\n'] { token lexbuf }
| "G" { GAUCHE }
| "D" { DROITE }
| "lecture_ecriture" { IO }
| ['a'-'z' 'A'-'Z' '0'-'9' '?']+ as mcle { MCLE(mcle) }
| eof { EOF }
|"BOUCLE{" { token lexbuf }
|"}BOUCLE" { token lexbuf }
|"BOUCLE2{" { token lexbuf }
|"}BOUCLE2" { token lexbuf }
|"SIALT{" { token lexbuf }
|"}SIALT" { token lexbuf }
|"ALT{" { token lexbuf }
|"}ALT" { token lexbuf }
|"D{" { token lexbuf }
|"}D" { token lexbuf }
|"SI{" { token lexbuf }
|"}SI" { token lexbuf }
|"FIN{" { token lexbuf }
|"}FIN" { token lexbuf }
|"G{" { token lexbuf }
|"}G" { token lexbuf }
|"ECRITURE{" { token lexbuf }
|"}ECRITURE" { token lexbuf }