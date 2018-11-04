-module(review).
-behaviour(supervisor).
-behaviour(application).
-export([init/1, start/2, stop/1, main/1]).
-compile(export_all).

main(A)    -> mad:main(A).
start()    -> start(normal,[]).
start(_,_) -> supervisor:start_link({local,review},review,[]).
stop(_)    -> ok.
init([])   -> emqttd_access_control:register_mod(auth, n2o_auth, [[]], 9998),
              {ok, {{one_for_one, 5, 10}, [spec()]}}.

spec()     ->
    Acceptors = application:get_env(?MODULE, acceptors, 4),
    MaxClients = application:get_env(?MODULE, max_clients, 512),
    Options = [{max_clients, MaxClients}, {acceptors, Acceptors}],
    Args = [{?MODULE, handle, [docroot()]}],
    Protocol = application:get_env(?MODULE, protocol, http),
    Port = application:get_env(?MODULE, port, 8000),
    mochiweb:child_spec(Protocol, Port, Options, Args).

dispatch(Path) ->
    case Path of
        [] -> application:get_env(?MODULE, main_page, "index.htm");
        _ -> Path
    end.

handle(Req, DocRoot) ->
    io:format("~s ~s~n", [Req:get(method), Req:get(path)]),
    try case Req:get(method) of
        'GET' ->
            "/" ++ Path = Req:get(path),
            RealPath = dispatch(Path),
            Req:serve_file(RealPath, DocRoot);
        'POST' ->
            Req:not_found();
        _Method ->
            Req:respond({501, [], []})
    end
    catch
    Type:What ->
        Report = ["web request failed",
                {path, Req:get(path)},
                {type, Type}, {what, What},
                {trace, erlang:get_stacktrace()}],
        error_logger:error_report(Report),
        Req:respond({500, [{"Content-Type", "text/plain"}],
                    "request failed, sorry\n"})
    end.

docroot() ->
    {file, Here} = code:is_loaded(?MODULE),
    Dir = filename:dirname(filename:dirname(Here)),
    StaticsRoot = application:get_env(?MODULE, "statics_root", "priv/www"),
    filename:join([Dir, StaticsRoot]).
