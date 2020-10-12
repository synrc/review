-ifndef(SEARCH_HRL).
-define(SEARCH_HRL, true).

-record('searchTmpl', { id   = kvs:seq([],[]) :: [] | binary() | list(),
                       name = [] :: list() | binary(),
                       feed = [] :: list() | binary(),
                       level = 1 :: integer(),
                       search_feed = [] :: list() | binary(),
                       doc = [] :: [] | tuple() }).

-endif.