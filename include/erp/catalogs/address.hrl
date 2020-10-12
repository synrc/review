-ifndef(ADDRESS_HRL).
-define(ADDRESS_HRL, true).

-include_lib("review/include/erp/catalogs/location.hrl").

-record('Address', { id = kvs:seq([],[]) :: term(),
					 name = [] :: [] | binary(),
                     city = [] :: [] | list(),
                     type = [] :: term() }).


-record('AdressName', { name = [] :: [] | binary(),
                        id = [] :: [] | term() }).

-endif.
