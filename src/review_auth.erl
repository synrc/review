-module(review_auth).
-include_lib("n2o/include/n2o.hrl").
-compile(export_all).

info({init, <<>>}, Req, State = #cx{session = Session}) ->
    {'Token', Token} = n2o_auth:gen_token([], Session),
    #cx{params = ClientId} = get(context),
    kvs:put({config, Token, State}),
    io:format("Token Saved: ~p~n",[Token]),
    n2o_nitro:info({init, Token}, Req, State);

info(Message,Req,State) -> {unknown,Message,Req,State}.
