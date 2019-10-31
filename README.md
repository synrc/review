REVIEW TT: MQTT Application
===========================

[![Build Status](https://travis-ci.com/synrc/review.svg?branch=master)](https://travis-ci.com/synrc/review)

TL;DR MQTT Sample IoT Application is a Nitro N2O pages that works on top
of MQTT connection between browser and server.

Intro
-----

Sample application consist of two pages `login` and `index`.
It creates WebSocket MQTT connection to `emqttd` server which is dependency of `n2o`.
The permanent example is accesible at <a href="http://review.n2o.space/index.htm">ns.synrc.com:8000</a>.

Index
-----

Init event.

```
event(init) ->
    nitro:wire("nodes="++nitro:to_list(length(n2o:ring()))++";"),
    #cx{session=Token,params=Id,node=Node} = get(context),
    Room = n2o:session(room),
    nitro:update(logout,
      #button { id=logout, body="Logout " ++ n2o:user(),postback=logout}),
    nitro:update(send,
      #button { id=send, body="Chat", source=[message], postback=chat}),
    nitro:update(heading, #h2 { id=heading, body=Room}),
    nitro:update(upload, #upload { id=upload   }),
    nitro:wire("mqtt.subscribe('room/"++Room++"',subscribeOptions);"),
    Topic = iolist_to_binary(["events/1/",Node,"/index/anon/",Id,"/",Token]),
    n2o:send_reply(<<>>, 2, Topic, term_to_binary(#client{id=Room,data=list})),
    nitro:wire(#jq{target=message,method=[focus,select]});
```

Chat event.

```
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
    n2o:send_reply(ClientId, 2, iolist_to_binary([<<"room/">>,Room]), M);
```

Client event.

```
event(#client{id=Room,data=list}) ->
    [ nitro:insert_top(history, nitro:jse(message_view(E#entry.from,E#entry.media)))
      || E <- lists:reverse(kvs:entries(kvs:get(feed,{room,Room}),entry,30)) ];
```

FTP event.

```
event(#ftp{sid=_Sid,filename=Filename,status={event,stop}}=Data) ->
    io:format("FTP Delivered ~p~n",[Data]),
    Name = hd(lists:reverse(string:tokens(nitro:to_list(Filename),"/"))),
    IP = application:get_env(review,host,"127.0.0.1"),
    erlang:put(message,
    nitro:render(#link{href=iolist_to_binary(["http://",IP,":8000/ftp/",
                       nitro_conv:url_encode(Name)]),body=Name})),
    event(chat);
```

Login
-----

Channel init.

```
event(init) ->
    nitro:wire("nodes="++nitro:to_list(length(n2o:ring()))++";"),
    nitro:update(loginButton,
          #button { id=loginButton, body="login",
                    postback=login,source=[user,pass]});
```

Login event.

```
event(login) ->
    User = nitro:to_list(n2o:q(user)),
    Room = nitro:to_list(n2o:q(pass)),
    n2o:user(User),
    n2o:session(room,Room),
    nitro:redirect("/index.htm");
```

Setup
-----

To run review application just clone, build and run:

```
$ git clone git://github.com/synrc/review
$ cd review
$ mad dep com pla rep
```

Then open it in browser:

```
$ open http://127.0.0.1:8000
```

Credits
-------
* Brought with ❤ by N2O community
