open Interpreteur

(*open Compilateur*)
open Thread

(*let compilation (turingStructure,fichiercompile)=         *)
(*		Compilateur.compilateur turingStructure fichiercompile*)
let repertoire = Sys.argv.(1)

let execution (programmeme, ruban, priorite) =
  while true do Interpreteur.machineDeTuring programmeme ruban priorite done

let threads =
  List.map (Thread.create execution)
    [ ((repertoire ^ "addition.1.transitions"),
       (repertoire ^ "addition.1.ruban"), 1);
      ((repertoire ^ "infini.1.transitions"),
       (repertoire ^ "infini.1.ruban"), 2);
      ((repertoire ^ "multiplicateur.1.transitions"),
       (repertoire ^ "multiplicateur.1.ruban"), 2);
      ((repertoire ^ "quotientPar2.1.transitions"),
       (repertoire ^ "quotientPar2.1.ruban"), 3);
      ((repertoire ^ "restePar2.1.transitions"),
       (repertoire ^ "restePar2.1.ruban"), 3);
      ((repertoire ^ "01.1.transitions"), (repertoire ^ "01.1.ruban"), 3) ]

let () = List.iter Thread.join threads

