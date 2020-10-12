-ifndef(SIGN_HRL).
-define(SIGN_HRL, true).

-record('signature', { id = [] :: list(),
                       cert = [] :: binary() | list(),
                       cn = [] :: binary() | list(),
                       type = [] :: binary() }).

-endif.
