-ifndef(CRMROLE_HRL).
-define(CRMROLE_HRL, true).

% LDAP inetOrgPerson OID=2.16.840.1.113730.3.2.2

-record(crmRole, { id          =  [] :: [] | term(),
                   bpmnRole = [] :: [] | atom() | list(),
                   name        = [] :: [] | binary(),
                   options = [] :: [] | list()}).
                
-endif.
