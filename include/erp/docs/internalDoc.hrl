-ifndef(INTERNAL_DOC_HRL).
-define(INTERNAL_DOC_HRL, true).

-include("erp/catalogs/person.hrl").

-record(internalDoc, { id= [] :: binary(),
                       guid= [] :: list(),
                       urgent=[] :: [] | boolean(),
                       date=[] :: [] | calendar:datetime(),
                       xml = [] :: [] | binary(),
                       hash = [] :: binary() | list(),
                       signature = [] :: binary() | list(),
                       document_type=[] :: list(), % catDoc dictionary
                       executor=[] :: [] | #'Person'{},
                       branch=[] :: [] | list(),
                       head=[] :: [] | #'Person'{},
                       body=[] :: term(),
                       signatory=[] :: [] | list(#'Person'{}),
                       target=[] :: [] | #'Person'{},
                       note=[] :: list(),
                       attachments = [] :: list(term()),
                       registered_by=[] :: [] | #'Person'{},
                       project = [] :: term(),
                       proc_id = [] :: list(),
                       created_by = [] :: term(),
                       created = [] :: term(),
                       modified_by = [] :: term(),
                       modified = [] :: term()

                      }).

-endif.
