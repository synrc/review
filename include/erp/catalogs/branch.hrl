-ifndef(BRANCH_HRL).
-define(BRANCH_HRL, true).

-include("erp/catalogs/location.hrl").
-include("erp/catalogs/person.hrl").

-record('Branch',   { id     = [] :: [] | binary(),
                      name   = [] :: list(),
                      org    = [] :: [] | binary(),
                      parent = [] :: [] | binary(),
                      short  = [] :: list(),
                      head   = [] :: [] | #'Person'{},
                      deputies   = [] :: list(#'Person'{}),
                      type   = [] :: [] | atom(),
                      loc    = [] :: [] | #'Loc'{} }).

-endif.
