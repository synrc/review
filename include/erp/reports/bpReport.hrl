-ifndef(BP_REPORT_HRL).
-define(BP_REPORT_HRL, true).

-record(bpReport, { id   = [] :: binary() | list(),
                     name = [] :: list(),
                     attachments = [] :: list(),
                     percentage = 0 :: float(),
                     duration = [] :: list(),
                     finished = [] :: list()
                     }).

-endif.