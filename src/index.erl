-module(index).
-description('MQTT Application').
-compile(export_all).
-include_lib("kvs/include/kvs.hrl").
-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/n2o.hrl").

event(init) ->
    #cx{session=Token,params=Id,node=Node} = Ctx = get(context),
    Room = n2o:session(room),
    nitro:update(logout,  #button { id=logout,  body="Logout "  ++ n2o:user(),       postback=logout}),
    nitro:update(send,    #button { id=send,    body="Chat",       source=[message], postback=chat}),
    nitro:update(upload,  #upload { id=attach }),
    nitro:wire("mqtt.subscribe('room/"++Room++"',subscribeOptions);"),
    %n2o_vnode:send_reply('', 2, Topic, term_to_binary(#client{data={Room,list}})),
    nitro:wire(#jq{target=message,method=[focus,select]});

event(chat) ->
    User    = n2o:user(),
    Message = nitro:q(message),
    Room    = n2o:session(room),
    io:format("Chat pressed: ~p\r~n",[{Room,Message,User}]),
    #cx{session=ClientId} = get(context),
    % kvs:add(#entry{id=kvs:next_id("entry",1),
    %                from=n2o:user(),feed_id={room,Room},media=Message}),
    nitro:insert_top(history, nitro:jse(message_view(User,Message)));

event(#client{data={Room,list}}) ->
    [ nitro:insert_top(history, nitro:jse(message_view(E#entry.from,E#entry.media)))
       || E <- lists:reverse(kvs:entries(kvs:get(feed,{room,Room}),entry,30)) ];

event(#ftp{sid=_Sid,filename=Filename,status={event,init}}=Data) ->
    ok;

event(#ftp{sid=_Sid,filename=Filename,status={event,stop}}=Data) ->
    Name = hd(lists:reverse(string:tokens(nitro:to_list(Filename),"/"))),
    IP = application:get_env(review,host,"127.0.0.1"),
    erlang:put(message,
    nitro:render(#link{href=iolist_to_binary(["http://",IP,":8000/n2o/",
                       nitro_conv:url_encode(Name)]),body=Name})),
    event(chat);

event(logout) ->  nitro:redirect("/login.htm"), n2o:session(room,[]);
event(Event)  -> io:format("Index Event: ~p", [Event]).

message_view(User,Message) ->
   iolist_to_binary(["<message><author>",User,"</author>",Message,"</message>"]).
