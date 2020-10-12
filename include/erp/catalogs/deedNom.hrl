-ifndef(DEED_NOM_HRL).
-define(DEED_NOM_HRL, true).

-record(deedNom, { name  = [] :: [] | binary() | list(),
                   expireDate = [] :: [] | calendar:datetime(),
                   id = [] :: [] | binary | list(),
                   index = [] :: [] | term(),
                   category = [] :: [] | term(),
                   note = [] :: term()
                 }).

-endif.