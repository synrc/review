-ifndef(ESQ_INQUIRE_HRL).
-define(ESQ_INQUIRE_HRL, true).

-include("erp/catalogs/person.hrl").

-record(esqInquire, { id= [] :: binary(),
                      guid= [] :: list(),
                      urgent=[] :: [] | boolean(),
                      date=[] :: [] | calendar:datetime(),
                      xml = [] :: [] | binary(),
                      hash = [] :: binary() | list(),
                      signature = [] :: binary() | list(),
                      document_type=[] :: letter | inquire,
                      surname=[] :: list(),
                      name=[] :: list(),
                      patronymic=[] :: list(),
                      koatuu_region=[] :: list(),
                      koatuu_place=[] :: list(),
                      topic = [] :: list(),
                      email = [] :: list(),
                      phone_number = [] :: list(),
                      address=[] :: [] | #'Address'{},
                      surname_from=[] :: list(),
                      name_from=[] :: list(),
                      patronymic_from=[] :: list(),
                      dueDate=[] :: [] | calendar:datetime(),
                      to=[] :: [] | #'Person'{},
                      note=[] :: list(),
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
