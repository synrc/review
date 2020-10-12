-ifndef(INQUIRE_HRL).
-define(INQUIRE_HRL, true).

-type form() :: email | phone | personal | representative | goverment | media | other.
-type sign() :: primary | secondary | double | serial | mass.
-type family() :: proposal | claim | application.
-type sex()  :: integer().
-type subject() :: individual | collective | anonymous.
-type type() :: telegram | letter | voice | electronical | petition.
-type author() :: war_participant | child_war | battle_participant | veneran_work | veteran_mil
                | inv | inv1 | inv2 | inv3 | inv_child | single_mother | mother_hero
                | many_child_family | chernobyl_victim | chernobyl_term | ukraine_hero | ussr_hero
                | social_work_hero | child | other.
-type social() :: pensioneer_warrior | worker | countryman | state_employee | gov_worker |
                  mil_worker | enterpreneur | unemployed | student | relegion_man |
                  prisoner | journalist | other.
-type approval() :: approved | rejected | explained | returned | forwarded | invalid.

-endif.
