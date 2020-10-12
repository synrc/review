-ifndef(ORGANIZATION_HRL).
-define(ORGANIZATION_HRL, true).

-include_lib("review/include/erp/catalogs/location.hrl").

-record('Organization', { id = [] :: list(),
                          name        = [] :: [] | binary(),
                          details     = [] :: [] | binary(),
                          hq          = "00000" :: term(),
                          orgname     = [] :: [] | binary(),
                          address     = [] :: [] | binary(),
                          director    = [] :: [] | binary(),
                          phones      = [] :: list() | binary(),
                          url         = [] :: [] | string(),
                          code        = [] :: list() | binary(),
                          login       = [] :: [] | binary(),
                          password    = [] :: [] | binary(),
                          location    = [] :: [] | #'Loc'{},
                          type        = [] :: term(),
                          keys        = 1 :: integer() }).

-endif.
