% lab2_network.pl
% Модель знаний для ЛР2

host(h1). host(h2). host(h3).
subnet(sA). subnet(sB).
host_in(h1,sA).
host_in(h2,sB).
host_in(h3,sA).
router(r1).
router_connects(r1,sA,sB).
link_up(h1,r1).
link_up(r1,h2).
link_up(h3,r1).
firewall_allows(sA,sB,tcp).
% firewall_blocks(sA,sB,tcp).

reachable_backward(H1,H2) :-
    host_in(H1,S), host_in(H2,S),
    link_up(H1,_), link_up(H2,_).

reachable_backward(H1,H2) :-
    host_in(H1,S1), host_in(H2,S2), S1 \= S2,
    router_connects(R,S1,S2),
    link_up(H1,R), link_up(R,H2),
    firewall_allows(S1,S2,_).

reachable_backward(H1,H2) :-
    reachable_backward(H2,H1).

:- dynamic fact_reachable/2, fact_not_reachable/2.

forward_init :-
    retractall(fact_reachable(_,_)),
    retractall(fact_not_reachable(_,_)).

apply_rules_forward :-
    host_in(H1,S1), host_in(H2,S2), S1 \= S2,
    router_connects(R,S1,S2),
    link_up(H1,R), link_up(R,H2),
    firewall_allows(S1,S2,_),
    \+ fact_reachable(H1,H2),
    assertz(fact_reachable(H1,H2)),
    fail.
apply_rules_forward.

apply_symmetry_forward :-
    fact_reachable(H1,H2),
    \+ fact_reachable(H2,H1),
    assertz(fact_reachable(H2,H1)),
    fail.
apply_symmetry_forward.

run_forward :-
    forward_init,
    apply_rules_forward,
    apply_symmetry_forward.

list_forward_reachable :-
    findall((H1,H2), fact_reachable(H1,H2), L),
    writeln('Forward reachable facts:'), writeln(L).
