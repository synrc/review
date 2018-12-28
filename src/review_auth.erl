-module(review_auth).
-include_lib("n2o/include/n2o.hrl").
-include_lib("kvs/include/entry.hrl").
-compile(export_all).

room() ->  <<"room/global">>.

info({join, _}, Req, State = #cx{session = Session}) ->
    {'Token', Token} = n2o_session:authenticate([], Session),
    #cx{params = _ClientId} = get(context),
    kvs:put({config, Token, State}),
    io:format("Token Saved: ~p~n",[Token]),
    n2o_nitro:info({init, Token}, Req, State);

info({load, _}, Req, State = #cx{session = _Session}) ->
    #cx{params = ClientId} = get(context),
    Room = room(),
    List = lists:reverse(kvs:entries(kvs:get(feed,{room,Room}),entry,10)),
    io:format("History sent to ~p.~n",[ClientId]),
    {reply, {binary, term_to_binary(List)}, Req, State};

info({message, Text}, Req, State = #cx{session = _Session}) ->
    #cx{params = ClientId} = get(context),
    Room = room(),
    kvs:add(#entry{id=kvs:next_id("entry",1), from= _Session ,feed_id={room,Room},media=Text}),
    n2o_vnode:send_reply(ClientId, 2, Room, Text),
    io:format("Message from client ~p.~n",[ClientId]),
    {reply, {binary, <<>>}, Req, State};

info(Message,Req,State) -> {unknown,Message,Req,State}.
