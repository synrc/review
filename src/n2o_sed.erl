-module(n2o_sed).
-description('MIA:CRM protocol').
-compile({parse_transform, bert_javascript}).
-include_lib("review/include/erp/catalogs/employee.hrl").
-export([info/3]).

info(#'Employee'{}, Req, State) ->
    io:format("ERP.UNO Employee object sent ~n"),
    {reply, {binary, term_to_binary({reply,1})}, Req, State};

info({'Employee',1} = X, Req, State) ->
    io:format("Employee tuple ~p~n",[X]),
    {reply, {bert, {reply,1}}, Req, State};

info(Message, Req, State) -> {unknown,Message, Req, State}.
