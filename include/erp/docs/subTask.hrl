-ifndef(SUB_TASK_HRL).
-define(SUB_TASK_HRL, true).

-include("erp/catalogs/person.hrl").

-ifndef(CRM_TASK).
-define(CRM_TASK, id= [] :: binary,
              type=[] :: list(),
              initiator = [] :: [] | #'Person'{},
              body = [] :: list(),
              sign = [] :: [] | boolean(),
              executor=[] :: [] | #'Person'{},
              registered_by=[] :: [] | #'Person'{},
              dueDate = [] :: [] | calendar:datetime(),
              date_complete=[] :: [] | calendar:datetime(),
              complete_comment=[] :: [] | list(),
              %    progress = [] :: [] | list(),
              attachments = [] :: list(term()),
              proc_id = [] :: list(),
              parent = [] :: term(),
              project = [] :: term()
            ).
-endif.

-record(subTask, { ?CRM_TASK }).


-endif.
