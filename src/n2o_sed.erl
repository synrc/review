-module(n2o_sed).
-description('MIA:CRM protocol').
-compile({parse_transform, bert_javascript}).
-include_lib("review/include/erp/catalogs/employee.hrl").
-include_lib("review/include/erp/catalogs/organization.hrl").
-include_lib("review/include/erp/catalogs/branch.hrl").
-export([info/3]).

info(#'Employee'{}, Req, State) ->
    io:format("ERP.UNO Employee object sent ~n"),
    {reply, {binary, term_to_binary({reply,1})}, Req, State};

info(#'Organization'{}, Req, State) ->
    io:format("ERP.UNO Organization object sent ~n"),
    {reply, {binary, term_to_binary({reply,1})}, Req, State};

info(#'Branch'{}, Req, State) ->
    io:format("ERP.UNO Branch object sent ~n"),
    {reply, {binary, term_to_binary({reply,1})}, Req, State};

info(Message, Req, State) -> {unknown,Message, Req, State}.
