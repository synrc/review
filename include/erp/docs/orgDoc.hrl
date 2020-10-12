-ifndef(ORG_DOC_HRL).
-define(ORG_DOC_HRL, true).

-include("erp/catalogs/person.hrl").

-record(orgDoc,  { id= [] :: binary(),
                   guid= [] :: list(),
                   urgent=[] :: [] | boolean(),
                   date = [] :: [] | calendar:datetime(),
                   xml = [] :: [] | binary(),
                   hash = [] :: binary() | list(),
                   signature = [] :: binary() | list(),
                   document_type = [] :: letter | inquire,
                   branch=[] :: [] | list(),
                   head=[] :: [] | #'Person'{},
                   executor=[] :: [] | #'Person'{},
                   body=[] :: [] | list(),
                   signatory = [] :: [] | list(#'Person'{}),
                   dueDate = [] :: [] | calendar:datetime(),
                   assigned = [] :: [] | #'Person'{},
                   target = [] :: [] | list(#'Person'{}),
                   canceled = [] :: [] | boolean(),
                   cancelDate = [] :: [] | calendar:datetime(),
                   registered_by=[] :: [] | #'Person'{},
                   editDate = [] :: [] | calendar:datetime(),
                   note = [] :: list(),
                   attachments = [] :: list(term()),
                   project = [] :: term(),
                   proc_id = [] :: list(),
                   created_by = [] :: term(),
                   created = [] :: term(),
                   modified_by = [] :: term(),
                   modified = [] :: term()

}).

-endif.
