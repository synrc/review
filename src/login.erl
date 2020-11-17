-module(login).
-compile(export_all).
-include_lib("kvs/include/kvs.hrl").
-include_lib("n2o/include/n2o.hrl").
-include_lib("nitro/include/nitro.hrl").

event(init) ->
    nitro:wire("nodes="++nitro:to_list(length(n2o_ring:members(mqtt)))++";"),
    nitro:update(loginButton,
          #button { id=loginButton, body="login",
                    postback=login,source=[user,pass]});

event(login) ->
    User = nitro:to_list(nitro:q(user)),
    Room = nitro:to_list(nitro:q(pass)),
    n2o:user(User),
    n2o:session(room,Room),
    nitro:redirect("/app/index.htm");

event(_) -> [].
