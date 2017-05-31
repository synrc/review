-module(index).
-compile(export_all).
-include_lib("kvs/include/entry.hrl").
-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/n2o.hrl").

event(init) ->
    nitro:wire("nodes="++nitro:to_list(length(n2o:ring()))++";"),
    #cx{session=Token,params=Id,node=Node} = get(context),
    Room = n2o:session(room),
    io:format("Room: ~p~n",[Room]),
    nitro:update(logout,  #button { id=logout,  body="Logout "  ++ n2o:user(),       postback=logout}),
    nitro:update(send,    #button { id=send,    body="Chat",       source=[message], postback=chat}),
    nitro:update(heading, #h2     { id=heading, body=Room}),
    nitro:update(upload,  #upload { id=upload   }),
    nitro:wire("mqtt.subscribe('room/"++Room++"',subscribeOptions);"),
    Topic = iolist_to_binary(["events/",Node,"/index/anon/",Id,"/",Token]),

    % Block Async
    n2o:send_reply(<<>>, 2, Topic, term_to_binary(#client{id=Room,data=list})),

    % True Async
    % [ n2o:send_reply(ClientId, 2, Topic, term_to_binary(#client{data={E#entry.from,E#entry.media}}))
    %  || E <- lists:reverse(kvs:entries(kvs:get(feed,{room,Room}),entry,30)) ],

    nitro:wire(#jq{target=message,method=[focus,select]});


event(chat) ->
    User    = n2o:user(),
    Message = n2o:q(message),
    Room    = n2o:session(room),
    #cx{session=ClientId} = get(context),
    io:format("Chat pressed: ~p\r~n",[{Room,ClientId,Message,User}]),
    kvs:add(#entry{id=kvs:next_id("entry",1),
                   from=n2o:user(),feed_id={room,Room},media=Message}),

    nitro:insert_top(history, nitro:jse(message_view(User,Message))),
    Actions = iolist_to_binary(n2o_nitro:render_actions(n2o:actions())),
    M = term_to_binary({io,Actions,<<>>}),
    io:format("Actions: ~p~n",[Actions]),

    n2o:send_reply(ClientId, 2, iolist_to_binary([<<"room/">>,Room]), M);

% proto of UI update

event(#client{id=Room,data=list}) ->
    [ nitro:insert_top(history, nitro:jse(message_view(E#entry.from,E#entry.media)))
      || E <- lists:reverse(kvs:entries(kvs:get(feed,{room,Room}),entry,30)) ];

event(#ftp{sid=Sid,filename=Filename,status={event,stop}}=Data) ->
    io:format("FTP Delivered ~p~n",[Data]),
    Name = hd(lists:reverse(string:tokens(nitro:to_list(Filename),"/"))),
    erlang:put(message,
    nitro:render(#link{href=iolist_to_binary(["/spa/",Sid,"/",nitro_conv:url_encode(Name)]),body=Name})),
    event(chat);

event(logout) -> nitro:redirect(n2o:session(room));
event(Event)  -> io:format("Event: ~p", [Event]).

main() -> [].

message_view(User,Message) ->
   iolist_to_binary(["<message><author>",User,"</author>",Message,"</message>"]).

