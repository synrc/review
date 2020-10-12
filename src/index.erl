-module(index).
-description('MQTT Application').
-compile(export_all).
-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/n2o.hrl").
-include_lib("kvs/include/kvs.hrl").

event(init) ->
    Room = n2o:session(room),
    n2o:reg(n2o:sid()),
    nitro:clear(history),
    nitro:update(logout,  #button { id=logout,  body="Logout "  ++ n2o:user(),       postback=logout}),
    nitro:update(send,    #button { id=send,    body="Chat",       source=[message], postback=chat}),
    nitro:update(upload,  #upload { id=attach }),
    nitro:wire(#jq{target=message,method=[focus,select]}),
    [ nitro:insert_top(history, msg(Msg))
        || {'$msg',_,_,_,_, Msg} <- lists:reverse(kvs:feed({room,Room}))];

event(chat) ->
    Usr     = n2o:user(),
    Message = nitro:q(message),
    Room    = n2o:session(room),
    Msg = {'$msg', kvs:seq([], []), [], [], Usr, nitro:jse(Message)},
    kvs:append(Msg, {room, Room}),
    nitro:insert_top(history, msg(Message)),
    nitro:wire(#jq{target=message,method=[focus,select]});

event(#ftp{sid=Sid,filename=Filename,status={event,stop}}=Data) ->
    Room    = n2o:session(room),
    Usr     = n2o:user(),
    Name = hd(lists:reverse(string:tokens(nitro:to_list(Filename),"/"))),
    Message = nitro:render(#link{href=iolist_to_binary(["/app/",Name]),body=Name}),
    Msg = {'$msg', kvs:seq([], []), [], [], Usr, nitro:jse(Message)},
    kvs:append(Msg,{room, Room}),
    nitro:insert_top(history, msg(Message)),
    nitro:wire(#jq{target=message,method=[focus,select]});

event(logout) ->  nitro:redirect("/login.htm"), n2o:session(room,[]);
event(Event)  -> io:format("Index Event: ~p", [Event]).

msg(M) ->
    Usr = n2o:user(),
    nitro:render(#message{body=[#author{body=Usr}, 
        nitro:jse(M)
    ]}).
