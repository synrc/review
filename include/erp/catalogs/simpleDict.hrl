-ifndef(SIMPLE_DICT_HRL).
-define(SIMPLE_DICT_HRL, true).

-record(simpleDict, { id   = [] :: [] | binary() | list(),
                        code = [] :: list(),
                        fullDesc = [] :: list(),
                        desc = [] :: list(),
                        etc = [] :: list() }).

-endif.
