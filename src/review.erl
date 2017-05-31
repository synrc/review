-module(review).
-behaviour(supervisor).
-behaviour(application).
-export([init/1, start/2, stop/1, main/1, fix/1]).
-include_lib("kvs/include/user.hrl").

main(A)    -> mad:main(A).
start()    -> application:start(kvs), start(normal,[]).
start(_,_) -> supervisor:start_link({local,review},review,[]).
stop(_)    -> ok.
init([])   -> application:set_env(n2o,session,n2o),
              application:set_env(n2o,pickler,n2o_secret),
              application:set_env(n2o,fixpath,{review,fix}),
              application:set_env(kvs,dba,store_mnesia),
              application:set_env(kvs,schema,[kvs_user, kvs_acl, kvs_feed, kvs_subscription ]),
              kvs:join(),
              %lager:set_loglevel(lager_console_backend, warning),
              {ok, {{one_for_one, 5, 10}, [spec()]}}.
spec()     -> ranch:child_spec(http, 100, ranch_tcp, port(), cowboy_protocol, env()).
env()      -> [ { env, [ { dispatch, points() } ] } ].
static()   ->   { dir, "apps/review/priv", mime() }.
static2()   ->  { dir, "deps/spa/priv",    mime() }.
n2o()      ->   { dir, "deps/n2o/priv",    mime() }.
mime()     -> [ { mimetypes, cow_mimetypes, all   } ].
port()     -> [ { port, application:get_env(n2o,port,8000)  } ].
points()   -> cowboy_router:compile([{'_', [
    { "/web/[...]",          nitro_static,  static2()},
    { "/n2o/[...]",          nitro_static,  n2o()},
    { "/[...]",          nitro_static,  static()},
    { "/rest/:resource",     rest_cowboy, []},
    { "/rest/:resource/:id", rest_cowboy, []} ]}]).

fix(  "apps/review/priv")         -> <<"apps/review/priv/index.htm">>;
fix(  "deps/n2o/priv")            -> <<"apps/review/priv/login.htm">>;
fix(<<"apps/review/priv/index">>) -> <<"apps/review/priv/index.htm">>;
fix(<<"apps/review/priv/login">>) -> <<"apps/review/priv/login.htm">>;
fix(<<"apps/review/priv/S.svg",Link/binary>>=X) -> X;
fix(<<"apps/review/priv/back.jpg",Link/binary>>=X) -> X;
fix(<<"apps/review/priv/synrc.css",Link/binary>>=X) -> X;
fix(<<"apps/review/priv/",Link/binary>>) -> io:format("xx: ~p~n",[Link]), <<"apps/review/priv/login.htm">>;
fix(Path)                         -> nitro:to_binary(Path).
