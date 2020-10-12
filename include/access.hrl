-ifndef(ACCESS_CONTROL_ID).
-define(ACCESS_CONTROL_ID, true).

-include_lib("review/include/erp/catalogs/employee.hrl").
-include_lib("review/include/erp/catalogs/organization.hrl").
-include_lib("review/include/erp/catalogs/branch.hrl").
-include_lib("review/include/erp/catalogs/fileDesc.hrl").

% API endpoints:
%
% CREATE  : New Document Combo Box
% EDIT    : Edit Form, Edit Button
% DELETE  : Red Cross Button
% NEXT    : End Task Button
-record(access, {cn, msg}).
-record(acid, {id = [] :: list() | binary(), % ACID
                 subject_type = [] :: organization | branch | employee | group,
                 subject = [] :: #'Organization'{} | #'Branch'{} | #'Employee'{},
                 api_endpoint = [] :: list() | binary(),
                 description = <<>> :: binary(),
                 object_type = [] :: fileDesc | doc | process | monitor,
                 object = [] :: #fileDesc{} | tuple(),
                 field_spec = [] :: list(atom()), % list of allowed/denied fields
                 type = auth :: auth | deny,
                 role_logic = [] :: list() | binary(), % role in /review/roles, role monikers aka logic roles
                 role_inbox = register :: register | resolution | crm
                            | execution | archive | approval | signing
                            | printsend | agreement | acquaintance % roles as distinct set of process stages
                                                                   % aka physical roles
                }).

-endif.
