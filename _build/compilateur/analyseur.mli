type token =
  | PARG
  | PARD
  | CRG
  | CRD
  | SEPARATEUR
  | SI
  | OU
  | BOUCLENEGATIVE
  | BOUCLE2
  | BOUCLE
  | GAUCHE
  | DROITE
  | ECRIS
  | FIN
  | EOF
  | SYMBOLE of (string)

val programme :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Grammaire.programme
