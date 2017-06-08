-module(review).
-behaviour(supervisor).
-behaviour(application).
-export([init/1, start/2, stop/1, main/1, fix/1, fix2/1]).
-include_lib("kvs/include/user.hrl").

main(A)    -> mad:main(A).
start()    -> application:start(kvs), start(normal,[]).
start(_,_) -> supervisor:start_link({local,review},review,[]).
stop(_)    -> ok.
init([])   -> application:set_env(n2o,session,n2o),
              application:set_env(n2o,pickler,n2o_secret),
              application:set_env(n2o,fixpath,{review,fix2}),
              application:set_env(kvs,dba,store_mnesia),
              lager:set_loglevel(lager_console_backend, error),
              kvs:join(),
              {ok, {{one_for_one, 5, 10}, [spec()]}}.
spec()     -> ranch:child_spec(http, 100, ranch_tcp, port(), cowboy_protocol, env()).
env()      -> [ { env, [ { dispatch, points() } ] } ].
static()   ->   { dir, "deps/review", mime() }.
static2()   ->  { dir, "deps/spa/priv", mime() }.
n2o()      ->   { dir, "deps/n2o/priv",    mime() }.
mime()     -> [ { mimetypes, cow_mimetypes, all   } ].
port()     -> [ { port, application:get_env(n2o,port,8000)  } ].
points()   -> cowboy_router:compile([{'_', [
    { "/web/[...]",          nitro_static,  static2()},
    { "/n2o/[...]",          nitro_static,  n2o()},
    { "/ws/[...]",           n2o_stream,  []},
    { "/[...]",              nitro_static,  static()},
    { "/rest/:resource",     rest_cowboy, []},
    { "/rest/:resource/:id", rest_cowboy, []} ]}]).

fix2(A) -> %io:format("FIX: ~p~n",[A]),
           fix(A).

fix(  "deps/review/priv")         -> <<"deps/review/index.htm">>;
fix(  "deps/review")              -> <<"deps/review/index.htm">>;
fix(  "deps/n2o/priv")            -> <<"deps/review/login.htm">>;
fix(<<"deps/review/index",_/binary>>) -> <<"deps/review/index.htm">>;
fix(<<"deps/review/login",_/binary>>) -> <<"deps/review/login.htm">>;
fix(<<"deps/review/S.svg",_/binary>>) -> <<"deps/review/S.svg">>;
fix(<<"deps/review/back.jpg",_/binary>>)  -> <<"deps/review/back.jpg">>;
fix(<<"deps/review/synrc.css",_/binary>>) -> <<"deps/review/synrc.css">>;
fix(Path) -> %io:format("xx: ~p~n",[Path]),
             nitro:to_binary(Path).
