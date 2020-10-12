-ifndef(DEED_CAT_HRL).
-define(DEED_CAT_HRL, true).

-record(deedCat, { id   = [] :: [] | binary() | list(),
                   type= [] :: [] | binary() | list(),
                   name = [] :: [] | term()
                    }).

-endif.