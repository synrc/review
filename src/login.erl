-module(login).
-compile(export_all).
-include_lib("kvs/include/feed.hrl").
-include_lib("n2o/include/n2o.hrl").
-include_lib("nitro/include/nitro.hrl").

event(init) ->
    nitro:wire("nodes="++nitro:to_list(length(n2o:ring()))++";"),
    nitro:update(loginButton,
          #button { id=loginButton, body="login", class=blue,
                    postback=login,source=[user,pass]});

event(login) ->
    User = nitro:to_list(n2o:q(user)),
    Room = nitro:to_list(n2o:q(pass)),
    n2o:user([]),
    n2o:cache(room,Room),
    nitro:redirect("index.htm?room="++Room);

event(_) -> [].
main()   -> [].