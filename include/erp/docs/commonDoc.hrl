-ifndef(COMMONDOC_HRL).
-define(COMMONDOC_HRL, true).

-record(commonDoc, {
  id = [] :: term(),
  date = [] :: [] | calendar:datetime(),
  proc_id = [] :: list()
}).

-endif.