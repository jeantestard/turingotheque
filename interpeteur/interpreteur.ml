module Interpreteur =
  struct
    open GrammaireTransitions

    (*open Xlib*)
    (*open Unix*)
    (*open GMain*)
    exception Programme_Termine

    let rec transitionSuivante tableTransitions etat symbole =
      match tableTransitions with
      | [] -> raise Programme_Termine
      | tete :: suite ->
          if (etat, symbole) = ((tete.etatCourant), (tete.symboleEntre))
          then
            ((tete.etatSuivant), (tete.symboleSortie),
             (tete.actionEffectuee))
          else transitionSuivante suite etat symbole

    let imprimeResultat fichierSortie ruban =
      Array.iter
        (fun symbole ->
           (output_string fichierSortie symbole;
            output_char fichierSortie ' '))
        ruban

    let rec
      interprete priorite nomProgramme tableTransitions ruban etat position =
      (print_string "interprete ";
       print_string etat;
       print_newline ();
       print_string " position de l'oeil = ";
       print_int position;
       print_newline ();
       print_string "configuration du ruban = ";
       let symbole = try ruban.(position) with | Invalid_argument err -> "?"
       in
         (imprimeResultat stdout ruban;
          print_newline ();
          print_string "symbole lu = ";
          print_string symbole;
          print_newline ();
          print_string "interruption du processus :";
          print_string nomProgramme;
          print_newline ();
          print_newline ();
          Thread.delay (float_of_int priorite);
          try
            let (etatSuivant, symboleSortie, actionEffectuee) =
              transitionSuivante tableTransitions etat symbole in
            let positionSuivante = position + actionEffectuee
            in
              try
                (ruban.(position) <- symboleSortie;
                 interprete priorite nomProgramme tableTransitions ruban
                   etatSuivant positionSuivante)
              with
              | Invalid_argument err ->
                  if position < 0
                  then
                    (assert (position = (-1));
                     (let positionSuivante = positionSuivante + 1
                      in
                        interprete priorite nomProgramme tableTransitions
                          (Array.append [| symboleSortie |] ruban)
                          etatSuivant positionSuivante))
                  else
                    (assert (position = (Array.length ruban));
                     interprete priorite nomProgramme tableTransitions
                       (Array.append ruban [| symboleSortie |]) etatSuivant
                       positionSuivante)
          with
          | Programme_Termine -> (print_string "Fin du nomProgramme "; ruban)))

    let machineDeTuring nomProgramme ruban priorite =
      let instructions = Lexing.from_channel (open_in nomProgramme) in
      let tableTransitions =
        AnalyseurTransitions.tableTransitions LexiqueTransitions.token
          instructions in
      let instructions = Lexing.from_channel (open_in ruban) in
      let ruban = AnalyseurRuban.ruban LexiqueRuban.token instructions in
      let ruban =
        interprete priorite nomProgramme tableTransitions
          (Array.of_list ruban) "etat0" 0
      in imprimeResultat stdout ruban

  end

