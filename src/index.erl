-module(index).
-description('MQTT Application').
-compile(export_all).
-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/n2o.hrl").
-include_lib("kvs/include/kvs.hrl").

event(init) ->
    Room = n2o:session(room),
    n2o:reg({room,Room}),
    n2o:reg(n2o:sid()),
    nitro:clear(history),
    nitro:update(logout,  #button { id=logout,  body="Logout "  ++ n2o:user(),       postback=logout}),
    nitro:update(send,    #button { id=send,    body="Chat",       source=[message], postback=chat}),
    nitro:update(upload,  #upload { id=attach }),
    nitro:wire(#jq{target=message,method=[focus,select]}),
    [ event(#client{data=E}) || E <- lists:reverse(kvs:feed({room,Room}))];

event(chat) ->
    Usr    = n2o:user(),
    Message = nitro:q(message),
    Room    = n2o:session(room),
    Msg = {'$msg', kvs:seq([], []), [], [], Usr, nitro:jse(Message)},
    kvs:append(Msg, {room, Room}),    
    nitro:insert_top(history, nitro:render(#message{body=[#author{body=Usr}, nitro:jse(Message)]}));

event(#client{data={'$msg',_,_,_, Usr, Msg}}) ->
    HTML = nitro:render(#message{body=[#author{body=Usr}, nitro:jse(Msg)]}),
    nitro:insert_top(history, HTML);

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
