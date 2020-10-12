-ifndef(ARCH_INQUIRE_HRL).
-define(ARCH_INQUIRE_HRL, true).

-include("erp/catalogs/location.hrl").

-record(archInquire, { id= [] :: binary(),
                       guid= [] :: list(),
                       xml = [] :: [] | binary(),
                       hash = [] :: binary() | list(),
                       signature = [] :: binary() | list(),
                       pages=0 :: integer(),
                       caseNo=[] :: [] | list(),
                       caseType=[] :: [] | list(),
                       volume=[] :: list(),
                       folio=[] :: list(),
                       oriDate=[] :: [] | calendar:datetime(),
                       dueDate=[] :: [] | calendar:datetime(),
                       category=[] :: [] | list(),
                       date=[] :: [] | calendar:datetime(),
                       registered_by=[] :: [],
                       storageLife=[] :: [] | calendar:datetime(),
                       storagePlace=[] :: [] | #'Loc'{},
                       closed=[] :: yes | no,
                       archived=[] :: yes | no,
                       attachments = [] :: list(term()),
                       proc_id = [] :: list(),
                       created_by = [] :: term(),
                       created = [] :: term(),
                       modified_by = [] :: term(),
                       modified = [] :: term()
 }).

-endif.
