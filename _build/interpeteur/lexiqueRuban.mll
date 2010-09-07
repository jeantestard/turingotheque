{ open AnalyseurRuban }

rule token = parse
[' ' '\t' '\r' '\n'] { token lexbuf }
| ['a'-'z' 'A'-'Z' '0'-'9' '$']+ as symbole { SYMBOLE(symbole) }
| eof { EOF }