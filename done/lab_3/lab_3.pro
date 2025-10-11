/* Produktsionnaya sistema: Operatsionnye sistemy */
/* Variant 1 */

domains
  fact = symbol
  rule_name = symbol

database
  working_memory(fact)
  used_rule(rule_name)
  derived_fact(fact)

predicates
  start
  init_working_memory
  clear_database
  forward_reasoning
  backward_reasoning(fact)
  nondeterm fire_rule(rule_name) - (i) (o)
  nondeterm can_fire
  check_condition(fact)
  add_fact(fact)
  display_working_memory
  display_result(fact)
  show_derivation_tree
  
  
goal
  start.

clauses
  start:-
    clear_database,
    write("\n=== OPERATSIONNYE SISTEMY ===\n"),
    init_working_memory,
    write("\nIshodnaya pamyat:\n"),
    display_working_memory,
    
    write("\n--- PRYAMOJ VYVOD ---\n"),
    forward_reasoning,
    write("\nRezultat:\n"),
    display_working_memory,
    show_derivation_tree,
    
    clear_database,
    init_working_memory,
    
    write("\n--- OBRATNYJ VYVOD ---\n"),
    write("Tsel: sistema_rabotaet\n"),
    backward_reasoning(sistema_rabotaet),
    display_result(sistema_rabotaet),
    !.

  clear_database:-
    retractall(working_memory(_)),
    retractall(used_rule(_)),
    retractall(derived_fact(_)).

  init_working_memory:-
    asserta(working_memory(zagruzchik_vypolnen)),
    asserta(working_memory(drajvery_zagruzheny)).

  fire_rule(r1):-
    not(used_rule(r1)),
    check_condition(processy_zapushcheny),
    check_condition(pamyat_vydelena),
    add_fact(planirovshchik_rabotaet),
    asserta(used_rule(r1)),
    asserta(derived_fact(planirovshchik_rabotaet)),
    write("R1: processy_zapushcheny I pamyat_vydelena => planirovshchik_rabotaet\n").

  fire_rule(r2):-
    not(used_rule(r2)),
    check_condition(yadro_zagruzheno),
    check_condition(drajvery_zagruzheny),
    add_fact(processy_zapushcheny),
    asserta(used_rule(r2)),
    asserta(derived_fact(processy_zapushcheny)),
    write("R2: yadro_zagruzheno I drajvery_zagruzheny => processy_zapushcheny\n").

  fire_rule(r3):-
    not(used_rule(r3)),
    check_condition(zagruzchik_vypolnen),
    add_fact(yadro_zagruzheno),
    asserta(used_rule(r3)),
    asserta(derived_fact(yadro_zagruzheno)),
    write("R3: zagruzchik_vypolnen => yadro_zagruzheno\n").

  fire_rule(r4):-
    not(used_rule(r4)),
    check_condition(planirovshchik_rabotaet),
    check_condition(fajlovaya_sistema_smontirovana),
    add_fact(sistema_rabotaet),
    asserta(used_rule(r4)),
    asserta(derived_fact(sistema_rabotaet)),
    write("R4: planirovshchik_rabotaet I fajlovaya_sistema_smontirovana => sistema_rabotaet\n").

  fire_rule(r5):-
    not(used_rule(r5)),
    check_condition(yadro_zagruzheno),
    add_fact(pamyat_vydelena),
    asserta(used_rule(r5)),
    asserta(derived_fact(pamyat_vydelena)),
    write("R5: yadro_zagruzheno => pamyat_vydelena\n").

  fire_rule(r6):-
    not(used_rule(r6)),
    check_condition(drajvery_zagruzheny),
    add_fact(fajlovaya_sistema_smontirovana),
    asserta(used_rule(r6)),
    asserta(derived_fact(fajlovaya_sistema_smontirovana)),
    write("R6: drajvery_zagruzheny => fajlovaya_sistema_smontirovana\n").

  can_fire:- fire_rule(_).
  
  check_condition(F):- working_memory(F),!.
  
  add_fact(F):- not(working_memory(F)), asserta(working_memory(F)),!.
  add_fact(_):-!.

  forward_reasoning:- can_fire, !, forward_reasoning.
  forward_reasoning.

  backward_reasoning(F):- 
    working_memory(F), 
    write("Fakt '"), write(F), write("' najden\n"),!.

  backward_reasoning(sistema_rabotaet):-
    write("=> sistema_rabotaet nuzhny: planirovshchik_rabotaet, fajlovaya_sistema_smontirovana\n"),
    backward_reasoning(planirovshchik_rabotaet),
    backward_reasoning(fajlovaya_sistema_smontirovana),
    fire_rule(r4),!.

  backward_reasoning(planirovshchik_rabotaet):-
    write("=> planirovshchik_rabotaet nuzhny: processy_zapushcheny, pamyat_vydelena\n"),
    backward_reasoning(processy_zapushcheny),
    backward_reasoning(pamyat_vydelena),
    fire_rule(r1),!.

  backward_reasoning(processy_zapushcheny):-
    write("=> processy_zapushcheny nuzhny: yadro_zagruzheno, drajvery_zagruzheny\n"),
    backward_reasoning(yadro_zagruzheno),
    backward_reasoning(drajvery_zagruzheny),
    fire_rule(r2),!.

  backward_reasoning(yadro_zagruzheno):-
    write("=> yadro_zagruzheno nuzhen: zagruzchik_vypolnen\n"),
    backward_reasoning(zagruzchik_vypolnen),
    fire_rule(r3),!.

  backward_reasoning(pamyat_vydelena):-
    write("=> pamyat_vydelena nuzhen: yadro_zagruzheno\n"),
    backward_reasoning(yadro_zagruzheno),
    fire_rule(r5),!.

  backward_reasoning(fajlovaya_sistema_smontirovana):-
    write("=> fajlovaya_sistema_smontirovana nuzhny: drajvery_zagruzheny\n"),
    backward_reasoning(drajvery_zagruzheny),
    fire_rule(r6),!.

  display_working_memory:-
    working_memory(F), 
    write("  "), write(F), write("\n"), 
    fail.
  display_working_memory.

  display_result(F):-
    working_memory(F), 
    write("\nUspeh! Fakt '"), write(F), write("' dokazan.\n"),!.
  display_result(F):-
    write("\nFakt '"), write(F), write("' ne mozhet byt dokazan.\n").

  show_derivation_tree:-
    write("\n--- Derevo vyvoda ---\n"),
    write("zagruzchik_vypolnen (ish) => yadro_zagruzheno (R3)\n"),
    write("drajvery_zagruzheny (ish)\n"),
    write("yadro_zagruzheno + drajvery_zagruzheny => processy_zapushcheny (R2)\n"),
    write("yadro_zagruzheno => pamyat_vydelena (R5)\n"),
    write("processy_zapushcheny + pamyat_vydelena => planirovshchik_rabotaet (R1)\n"),
    write("drajvery_zagruzheny => fajlovaya_sistema_smontirovana (R6)\n"),
    write("planirovshchik_rabotaet + fajlovaya_sistema_smontirovana => sistema_rabotaet (R4)\n").