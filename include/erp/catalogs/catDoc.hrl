-ifndef(CAT_DOC_HRL).
-define(CAT_DOC_HRL, true).

-record('catDoc', { id   = [] :: [] | binary() | list(),
                    code = [] :: list(),
                    fullDesc = [] :: list(),
                    desc = [] :: list(),
                    sign = [] :: term(),
                    group = none :: none | input | output | internal | directive,
                    dueDate = [] :: [] | calendar:datetime(),
                    validTimeRange = {[],[]} :: {calendar:datetime(),calendar:datetime()},
                    noRule = [] :: term(),
                    docRule = [] :: term(),
                    etc = [] :: list() }).

-endif.
