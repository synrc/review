-ifndef(EMPLOYEE_HRL).
-define(EMPLOYEE_HRL, true).

-include_lib("review/include/erp/catalogs/organization.hrl").
-include_lib("review/include/erp/catalogs/branch.hrl").
-include_lib("review/include/erp/catalogs/location.hrl").
-include_lib("review/include/erp/catalogs/person.hrl").

% Employee{cn="Кримчук Сергій",code="3916",person=Person}
% EmployeeCode{code="3916",cn="Кримчук Сергій"}

-record('Employee',    { id          = kvs:seq([],[]) :: term(),
                         person      = [] :: [] | #'Person'{},
                         org         = [] :: [] | #'Organization'{},
                         branch      = [] :: #'Branch'{} | list(),
                         code        = [],
                         surname     = [],
                         name        = [],
                         middle_name = [],
                         sex         = [],
                         birthday    = [],
                         hired       = [],
                         fired       = [],
                         inn         = [],
                         position    = [],
                         number      = [],
                         title       = [] :: list(),
                         role        = [] :: list(),
                         phone       = [] :: list() | binary(),
                         mail        = [] :: list(),
                         type        = [] :: term() }).

-record('EmployeeCode', { code       = [] :: [] | term(),
                          cn         = [] :: [] | term() }).

-endif.
