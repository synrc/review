-module(review).

-behaviour(application).

-behaviour(supervisor).

-export([start/2, stop/1, init/1]).

% app/sup
init(_Args) ->
    Dispatch = cowboy_router:compile([{'_',
                                       [{"/",
                                         cowboy_static,
                                         {file, "priv/static/index.html", mime()}},
                                        {"/n2o/[...]",
                                         cowboy_static,
                                         {dir, "deps/n2o/priv", mime()}},
                                        {"/nitro/[...]",
                                         cowboy_static,
                                         {dir, "deps/nitro/priv/js", mime()}},
                                        {"/[...]",
                                         cowboy_static,
                                         {dir, "priv/static", mime()}}]}]),
    Opts = #{connection_type => worker,
             handshake_timeout => 10000, max_connections => 1000,
             num_acceptors => 100, shutdown => 5000,
             socket_opts =>
                 [{port, application:get_env(n2o, port, 8000)}]},
    Spec = ranch:child_spec(http,
                            ranch_tcp,
                            Opts,
                            cowboy_clear,
                            #{env => #{dispatch => Dispatch}}),
    {ok, {{one_for_one, 10, 100}, [Spec]}}.

start(_StartType, _StartArgs) ->
    kvs:join(),
    n2o:start_mqtt(),
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

stop(_State) -> ranch:stop_listener(http).

mime() -> [{mimetypes, cow_mimetypes, all}].
