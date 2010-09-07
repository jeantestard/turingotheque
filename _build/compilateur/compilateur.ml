module Compilateur =
  struct
    open Grammaire

    open Printf

    let reference = open_out Sys.argv.(2)

    let ecrisTransition (etatCourant, symboleEntre, etatSuivant,
                         symboleSortie, actionEffectuee)
                        =
      fprintf reference "etat%i %s etat%i %s %s\n" etatCourant symboleEntre
        etatSuivant symboleSortie actionEffectuee

    exception SymboleInconnu of string

    let verifieSymbole alphabet symbole =
      if List.mem symbole alphabet
      then ()
      else raise (SymboleInconnu symbole)

    let check_listeSymboles alphabet listeSymboles =
      List.iter (verifieSymbole alphabet) listeSymboles

    let rec transforme (symboles, etat) =
      function
      | Gauche ->
          (fprintf reference "G{\n";
           List.iter
             (fun sym -> ecrisTransition (etat, sym, (etat + 1), sym, "G"))
             symboles;
           fprintf reference "}G\n";
           (symboles, (etat + 1)))
      | Droite ->
          (fprintf reference "D{\n";
           List.iter
             (fun sym -> ecrisTransition (etat, sym, (etat + 1), sym, "D"))
             symboles;
           fprintf reference "}D\n";
           (symboles, (etat + 1)))
      | Ecriture out_sym ->
          (fprintf reference "ECRITURE{\n";
           verifieSymbole symboles out_sym;
           List.iter
             (fun sym ->
                ecrisTransition
                  (etat, sym, (etat + 1), out_sym, "lecture_ecriture"))
             symboles;
           fprintf reference "}ECRITURE \n";
           (symboles, (etat + 1)))
      | Si (listeSymboles, expressions) ->
          (fprintf reference "SI{\n";
           check_listeSymboles symboles listeSymboles;
           let (symboles, etatSuivant) =
             transforme (symboles, (etat + 1)) expressions
           in
             (List.iter
                (fun sym ->
                   let etatSuivant =
                     if List.mem sym listeSymboles
                     then etat + 1
                     else etatSuivant
                   in
                     ecrisTransition
                       (etat, sym, etatSuivant, sym, "lecture_ecriture"))
                symboles;
              fprintf reference "}SI\n";
              (symboles, etatSuivant)))
      | Alt (listeSymboles, if_expressions, else_expressions) ->
          (fprintf reference "SIALT{\n";
           check_listeSymboles symboles listeSymboles;
           let (symboles, else_etat) =
             transforme (symboles, (etat + 1)) if_expressions
           in
             (List.iter
                (fun sym ->
                   let etatSuivant =
                     if List.mem sym listeSymboles
                     then etat + 1
                     else else_etat + 1
                   in
                     ecrisTransition
                       (etat, sym, etatSuivant, sym, "lecture_ecriture"))
                symboles;
              fprintf reference "}SIALT\n";
              fprintf reference "ALT{\n";
              let (symboles, etatSuivant) =
                transforme (symboles, (else_etat + 1)) else_expressions
              in
                (List.iter
                   (fun sym ->
                      ecrisTransition
                        (else_etat, sym, etatSuivant, sym,
                         "lecture_ecriture"))
                   symboles;
                 fprintf reference "}ALT\n";
                 (symboles, etatSuivant))))

      | Boucle2 (listeSymboles, expressions) ->
          (fprintf reference "BOUCLE2{\n";
           check_listeSymboles symboles listeSymboles;
           let (symboles, etatReference) =
             transforme (symboles, (etat + 1)) expressions in
           let etatSuivant = etatReference + 1
           in
             (List.iter
                (fun sym ->
                   let etatSuivant =
                     if List.mem sym listeSymboles
                     then etat + 1
                     else etatSuivant
                   in
                     ecrisTransition
                       (etat, sym, etatSuivant, sym, "lecture_ecriture"))
                symboles;
              List.iter
                (fun sym ->
                   ecrisTransition
                     (etatReference, sym, etat, sym, "lecture_ecriture"))
                symboles;
              fprintf reference "}BOUCLE2\n";
              (symboles, etatSuivant)))
      | Fin ->
          (fprintf reference "FIN{\n";
           List.iter
             (fun sym ->
                ecrisTransition
                  (etat, sym, (etat + 2), sym, "lecture_ecriture"))
             symboles;
           fprintf reference "}FIN\n";
           (symboles, (etat + 1)))

      | Boucle expressions ->
          let (symboles, etatReference) =
            transforme (symboles, (etat + 1)) expressions in
          let etatSuivant = etatReference + 1
          in
            (fprintf reference "BOUCLE{\n";
             List.iter
               (fun sym ->
                  let etatSuivant = etat + 1
                  in
                    ecrisTransition
                      (etat, sym, etatSuivant, sym, "lecture_ecriture"))
               symboles;
             List.iter
               (fun sym ->
                  ecrisTransition
                    (etatReference, sym, etat, sym, "lecture_ecriture"))
               symboles;
             fprintf reference "}BOUCLE\n";
             (symboles, etatSuivant))

      | Racine expressions ->

          List.fold_left transforme (symboles, etat) expressions
      | _ -> (symboles, etat)

    let compile =
      function
      | Programme (symboles, expressions) ->
          List.fold_left transforme (symboles, 0) expressions

    let compilateur =
      let lexiqueInstructions = Lexing.from_channel (open_in Sys.argv.(1))
      in
        compile (Analyseur.programme Lexique.token lexiqueInstructions)

  end

