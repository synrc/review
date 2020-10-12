-ifndef(DICT_HRL).
-define(DICT_HRL, true).

-record('dict', { id = [] :: list(),
                  type = [] :: binary(),
                  name = [] :: binary()}).

-endif.