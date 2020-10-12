-ifndef(DEPUTY_INQUIRE_HRL).
-define(DEPUTY_INQUIRE_HRL, true).

-include("erp/catalogs/person.hrl").
-include("erp/catalogs/location.hrl").
-include("erp/catalogs/address.hrl").

-record(deputyInquire, { id= [] :: binary(),
                         guid= [] :: list(),
                         urgent=[] :: [] | boolean(),
                         number=[] :: list(),
                         date=[] :: [] | calendar:datetime(),
                         xml = [] :: [] | binary(),
                         hash = [] :: binary() | list(),
                         signature = [] :: binary() | list(),
                         type=[] :: letter | inquire,
                         corr=[] :: [] | list(),
                         signed=[] :: [] | list(),
                         number_out=[] :: [] | list(),
                         date_out=[] :: calendar:datetime(),
                         request=[] :: [] | list(),
                         committee=[] :: [] | list(),
                         deputy=[] :: [] | list(),
                         id_ndu=[] :: [] | list(),
                         date_ndu=[] :: [] | calendar:datetime(),
                         address_ndu=[] :: [] | #'Address'{},
                         content= [] :: list(),
                         topic=[] :: list(),
                         surname=[] :: list(),
                         name=[] :: list(),
                         patronymic=[] :: list(),
                         address=[] :: [] | #'Address'{},
                         from=[] :: [] | #'Person'{},
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
