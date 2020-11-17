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
    [event(#client{data=E}) || E <- lists:reverse(kvs:feed({room,Room}))];

event(chat) ->
    event(#client{data={'$msg', kvs:seq([], []), [], [], n2o:user(), nitro:q(message)}});

event(#ftp{sid=_Sid,filename=Filename,status={event,stop}}) ->
    Name = hd(lists:reverse(string:tokens(nitro:to_list(Filename),"/"))),
    Message = nitro:render(#link{href=iolist_to_binary(["/app/",Name]),body=Name}),
    event(#client{data={'$msg',kvs:seq([], []), [], [], n2o:user(), Message}});

event(#client{data={'$msg',_,_,_,User,Message}=Msg}) ->
    kvs:append(Msg,{room, n2o:session(room)}),
    HTML = nitro:to_list(Message),
    nitro:wire(#jq{target=message,method=[focus,select]}),
    nitro:insert_top(history, nitro:render(#message{body=[#author{body=User},HTML]}));

event(logout) ->  nitro:redirect("/login.htm"), n2o:session(room,[]);
event(Event)  -> io:format("Index Event: ~p", [Event]).
