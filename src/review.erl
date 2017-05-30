-module(review).
-behaviour(supervisor).
-behaviour(application).
-export([init/1, start/2, stop/1, main/1]).
-include_lib("kvs/include/user.hrl").

main(A)    -> mad:main(A).
start()    -> application:start(kvs), start(normal,[]).
start(_,_) -> supervisor:start_link({local,review},review,[]).
stop(_)    -> ok.
init([])   -> application:set_env(n2o,session,n2o),
              application:set_env(n2o,pickler,n2o_secret),
              application:set_env(kvs,dba,store_mnesia),
              application:set_env(kvs,schema,[kvs_user, kvs_acl, kvs_feed, kvs_subscription ]),
              kvs:join(),
              %lager:set_loglevel(lager_console_backend, warning),
              {ok, {{one_for_one, 5, 10}, [spec()]}}.
spec()     -> ranch:child_spec(http, 100, ranch_tcp, port(), cowboy_protocol, env()).
env()      -> [ { env, [ { dispatch, points() } ] } ].
static()   ->   { dir, "apps/review/priv", mime() }.
static2()   ->   { dir, "deps/spa/priv", mime() }.
n2o()      ->   { dir, "deps/n2o/priv",    mime() }.
mime()     -> [ { mimetypes, cow_mimetypes, all   } ].
port()     -> [ { port, application:get_env(n2o,port,8000)  } ].
points()   -> cowboy_router:compile([{'_', [
    { "/spa/[...]",          nitro_static,  static()},
    { "/web/[...]",          nitro_static,  static2()},
    { "/n2o/[...]",          nitro_static,  n2o()},
    { "/rest/:resource",     rest_cowboy, []},
    { "/rest/:resource/:id", rest_cowboy, []} ]}]).