type token =
  | EOF
  | SYMBOLE of (string)

val ruban :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> string list
