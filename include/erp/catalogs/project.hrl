-ifndef(PROJECT_HRL).
-define(PROJECT_HRL, true).

-record(project, { approvers = [] :: [] | term(),
                   signer = [] :: binary() | list(),
                   comment = [] :: binary() | list(),
                   signature = [] :: [] | list(),
                   creator = [] :: binary() | list()
                      }).

-endif.
