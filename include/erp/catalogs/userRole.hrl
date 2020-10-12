-ifndef(USERROLE_HRL).
-define(USERROLE_HRL, true).

-record(userRole, {
                   crmRole = [] :: [] | atom() | list(),
                   substUsers = [] :: [] | list(),
                   expired = []
                
                  }).
                
-endif.