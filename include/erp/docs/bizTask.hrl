-ifndef(BIZ_TASK_HRL).
-define(BIZ_TASK_HRL, true).

-include("erp/catalogs/person.hrl").
-include("erp/catalogs/location.hrl").

-record(bizTask, { id= [] :: binary(),
                   initiator = [] :: [] | #'Person'{},
                   point=[] :: [] | list(),
                   body = [] :: list(),
                   sign = [] :: [] | boolean(),
                   executor=[] :: [] | #'Person'{},
                   subexecutors = [] :: [] | list(#'Person'{}),
                   notify = [] :: [] | list(#'Person'{}),
                   fromDate = [] :: [] | calendar:datetime(),
                   dueDate = [] :: [] | calendar:datetime(),
                   priority = [] :: term(),
                   reminder = [] :: term(),
                   taskTime = [] :: integer(),
                   control=[] :: [] | boolean(),
                   period=[] :: [] | list(),
                   date_start=[] :: [] | calendar:datetime(),
                   date_finish=[] :: [] | calendar:datetime(),
                   date_control=[] :: [] | calendar:datetime(),
                   control_by=[] :: [] | list(#'Person'{}),
                   comment=[] :: [] | list(),
                   remove=[] :: [] | boolean(),
                   registered_by=[] :: [] | #'Person'{},
                   removed_by=[] :: [] | #'Person'{},
                   removed_date=[] :: [] | calendar:datetime(),
                   date_complete=[] :: [] | calendar:datetime(),
                   controller_comment=[] :: [] | list(),
                   complete_comment=[] :: [] | list(),
                   progress = [] :: [] | list(),
                   attachments = [] :: list(term()),
                   proc_id = [] :: list(),
                   parent = [] :: term(),
                   created_by = [] :: term(),
                   created = [] :: term(),
                   modified_by = [] :: term(),
                   modified = [] :: term()
                 }).

-endif.
