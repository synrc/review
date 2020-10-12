-ifndef(ACT_DELETION_HRL).
-define(ACT_DELETION_HRL, true).

-record(actDeletion, { id= [] :: binary(),
                       guid= [] :: list(),
                       date = [] :: [] | calendar:datetime(),
                       xml = [] :: [] | binary(),
                       hash = [] :: binary() | list(),
                       signature = [] :: binary() | list(),
                       dueDate = [] :: [] | calendar:datetime(),
                       registered_by=[] :: [],
                       branch = [] :: term(),
                       category = [] :: term(),
                       attachments = [] :: list(term()),
                       proc_id = [] :: list()
                     }).

-endif.