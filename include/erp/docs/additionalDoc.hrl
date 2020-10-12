-ifndef(ADDITIONAL_DOC_HRL).
-define(ADDITIONAL_DOC_HRL, true).

-include("erp/catalogs/person.hrl").

-record(additionalDoc, { id= [] :: binary(),
                         guid= [] :: list(),
                         date = [] :: [] | calendar:datetime(),
                         xml = [] :: [] | binary(),
                         hash = [] :: binary() | list(),
                         signature = [] :: binary() | list(),
                         document_type = [] :: letter | inquire,
                         corr=[] :: [] | #'Person'{},
                         executor=[] :: [] | #'Person'{},
                         branch=[] :: [] | list(),
                         head=[] :: [] | list(),
                         body=[] :: [] | list(),
                         signatory = [] :: [] | list(#'Person'{}),
                         control = [] :: [] | #'Person'{},
                         note = [] :: list(),
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
