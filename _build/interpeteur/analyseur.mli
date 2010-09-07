type token =
  | GAUCHE
  | DROITE

  | IO
  | EOF
  | MCLE of (string)

val tableTransitions :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Grammaire.transition list
