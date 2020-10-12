-ifndef(CITIZEN_INQUIRE_HRL).
-define(CITIZEN_INQUIRE_HRL, true).

-include("erp/catalogs/person.hrl").
-include("erp/catalogs/location.hrl").
-include("erp/catalogs/inquire.hrl").
-include("erp/catalogs/address.hrl").

-record(citizenInquire, { id= [] :: binary(),
                          guid= [] :: list(),
                          date=[] :: [] | calendar:datetime(),
                          xml = [] :: [] | binary(),
                          hash = [] :: binary() | list(),
                          signature = [] :: binary() | list(),
                          document_type=[] :: letter | inquire,
                          surname=[] :: list(),
                          name=[] :: list(),
                          patronymic=[] :: list(),
                          gender=[] :: list(),
                          email=[] :: list(),
                          phone_number=[] :: list(),
                          subject=[] :: list(),
                          subject_count=[] :: [] | list(),
                          author_type=[] :: [] | list(),
                          social_status= [] :: list(),
                          koatuu_region=[] :: list(),
                          koatuu_place=[] :: list(),
                          address=[] :: [] | #'Address'{},
                          topic=[] :: list(),
                          issue=[] :: list(),
                          issue_type=[] :: list(),
                          issue_specie=[] :: list(),
                          form=[] :: list(),
                          averment=[] :: list(),
                          from=[] :: [] | #'Person'{} | #'Organization'{},
                          number_out=[] :: list(),
                          date_out=[] :: [] | calendar:datetime(),
                          to=[] :: [] | #'Person'{},
                          dueDate=[] :: [] | calendar:datetime(),
                          result=[] :: [] | list(),
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
