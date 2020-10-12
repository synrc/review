-ifndef(IN_ORDER_HRL).
-define(IN_ORDER_HRL, true).

-include("erp/catalogs/person.hrl").

-record(inputOrder, { id= [] :: binary(),
                      guid= [] :: list(),
                      urgent=[] :: [] | boolean(),
                      date=[] :: [] | calendar:datetime(),
                      xml = [] :: [] | binary(),
                      hash = [] :: binary() | list(),
                      signature = [] :: binary() | list(),
                      document_type=[] :: letter | inquire,
                      corr=[] :: [] | list(),
                      branch=[] :: [] | list(),
                      head=[] :: [] | #'Person'{},
                      signed=[] :: [] | list(),
                      number_out= [] :: list(),
                      date_out=[] :: calendar:datetime(),
                      content= [] :: list(),
                      note=[] :: list(),
                      dueDate=[] :: [] | calendar:datetime(),
                      dueDateTime = [] :: list(),
                      to=[] :: [] | #'Person'{},
                      main_sheets=[] :: [] | list(),
                      add_sheets=[] :: [] | list(),
                      registered_by=[] :: [] | #'Person'{},
                      coordination=[] :: list(),
                      attachments = [] :: list(term()),
                      proc_id = [] :: list(),
                      created_by = [] :: term(),
                      created = [] :: term(),
                      modified_by = [] :: term(),
                      modified = [] :: term()
 }).


-endif.
