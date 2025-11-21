/* Production System: Operating Systems Functioning */
/* All comments and text are in English */

/* Domains */
domains
    fact = symbol
    rule_name = symbol

/* Database */
database
    working_memory(fact)
    used_rule(rule_name)
    derived_fact(fact)

/* Predicates */
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

/* Goal */
goal
    start.

/* Clauses */
clauses

/* Start program */
start:-
    clear_database,
    write("\n=== OPERATING SYSTEMS FUNCTIONING ===\n"),
    init_working_memory,
    write("\nInitial working memory:\n"),
    display_working_memory,

    write("\n--- FORWARD REASONING ---\n"),
    forward_reasoning,
    write("\nResult after forward reasoning:\n"),
    display_working_memory,
    show_derivation_tree,

    clear_database,
    init_working_memory,

    write("\n--- BACKWARD REASONING ---\n"),
    write("Goal: system_operational\n"),
    backward_reasoning(system_operational),
    display_result(system_operational),
    !.

/* Clear database */
clear_database:-
    retractall(working_memory(_)),
    retractall(used_rule(_)),
    retractall(derived_fact(_)).

/* Initialize working memory with some simple facts */
init_working_memory:-
    /* 5 simple sentences inserted here */
    asserta(working_memory(cpu_running)),         !,
    asserta(working_memory(memory_allocated)),   !,
    asserta(working_memory(scheduler_active)),   !,
    asserta(working_memory(drivers_loaded)),     !,
    asserta(working_memory(file_system_mounted)),!.

/* Rules for complex sentences */

/* Rule 1: cpu_running AND memory_allocated => processes_execute */
fire_rule(r1):-
    not(used_rule(r1)),
    check_condition(cpu_running),
    check_condition(memory_allocated),
    add_fact(processes_execute),
    asserta(used_rule(r1)),
    asserta(derived_fact(processes_execute)),
    write("R1: cpu_running AND memory_allocated => processes_execute\n").

 /* Rule 2: scheduler_active AND file_system_mounted => system_operational */
fire_rule(r2):-
    not(used_rule(r2)),
    check_condition(scheduler_active),
    check_condition(file_system_mounted),
    add_fact(system_operational),
    asserta(used_rule(r2)),
    asserta(derived_fact(system_operational)),
    write("R2: scheduler_active AND file_system_mounted => system_operational\n").

/* Fire any applicable rule */
can_fire:- fire_rule(_).

/* Check if a condition is true in working memory */
check_condition(F):- working_memory(F),!.

/* Add a fact to working memory if not present */
add_fact(F):- not(working_memory(F)), asserta(working_memory(F)),!.
add_fact(_):-!.

/* Forward reasoning */
forward_reasoning:- can_fire, !, forward_reasoning.
forward_reasoning.

/* Backward reasoning */
backward_reasoning(F):- 
    working_memory(F),
    write("Fact '"), write(F), write("' found\n"),!.

backward_reasoning(system_operational):-
    write("=> system_operational needs: scheduler_active, file_system_mounted\n"),
    backward_reasoning(scheduler_active),
    backward_reasoning(file_system_mounted),
    fire_rule(r2),!.

backward_reasoning(processes_execute):-
    write("=> processes_execute needs: cpu_running, memory_allocated\n"),
    backward_reasoning(cpu_running),
    backward_reasoning(memory_allocated),
    fire_rule(r1),!.

/* Display current working memory */
display_working_memory:-
    working_memory(F),
    write("  "), write(F), write("\n"),
    fail.
display_working_memory.

/* Display result of backward reasoning */
display_result(F):-
    working_memory(F),
    write("\nSuccess! Fact '"), write(F), write("' proven.\n"),!.
display_result(F):-
    write("\nFact '"), write(F), write("' cannot be proven.\n").

 /* Show derivation tree */
show_derivation_tree:-
    write("\n--- Derivation Tree ---\n"),
    write("cpu_running (initial)\n"),
    write("memory_allocated (initial)\n"),
    write("cpu_running + memory_allocated => processes_execute (R1)\n"),
    write("scheduler_active (initial)\n"),
    write("file_system_mounted (initial)\n"),
    write("scheduler_active + file_system_mounted => system_operational (R2)\n").
