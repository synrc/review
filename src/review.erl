-module(review).
-behaviour(supervisor).
-behaviour(application).
-export([init/1, start/2, stop/1, main/1, fix/1, fix2/1]).
-include_lib("kvs/include/user.hrl").


-compile(export_all).

main(A)    -> mad:main(A).
start()    -> start(normal,[]).
start(_,_) -> supervisor:start_link({local,review},review,[]).
stop(_)    -> ok.
init([])   -> application:set_env(n2o,session,n2o_session),
              application:set_env(n2o,pickler,n2o_secret),
              application:set_env(n2o,fixpath,{review,fix2}),
              application:set_env(kvs,dba,store_mnesia),
              emqttd_access_control:register_mod(auth, n2o_auth, [[]], 9998),

              {ok, {{one_for_one, 5, 10}, [spec()]}}.

spec()     ->
    Acceptors = application:get_env(?MODULE, acceptors, 4),
    MaxClients = application:get_env(?MODULE, max_clients, 512),
    Options = [{max_clients, MaxClients}, {acceptors, Acceptors}],
    Args = [{?MODULE, handle, [docroot()]}],
    Protocol = application:get_env(?MODULE, protocol, http),
    Port = application:get_env(?MODULE, port, 8000),
    mochiweb:child_spec(Protocol, Port, Options, Args).

merge_opts(Defaults, Options) ->
    lists:foldl(
        fun({Opt, Val}, Acc) ->
                case lists:keymember(Opt, 1, Acc) of
                    true ->
                        lists:keyreplace(Opt, 1, Acc, {Opt, Val});
                    false ->
                        [{Opt, Val}|Acc]
                end;
            (Opt, Acc) ->
                case lists:member(Opt, Acc) of
                    true -> Acc;
                    false -> [Opt | Acc]
                end
        end, Defaults, Options).

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


% spec()     -> ranch:child_spec(http, 100, ranch_tcp, port(), cowboy_protocol, env()).
% env()      -> [ { env, [ { dispatch, points() } ] } ].
% static()   ->   { dir, "deps/review", mime() }.
% static2()   ->  { dir, "deps/spa/priv", mime() }.
% n2o(Dir)      ->   { dir, Dir,    mime() }.
% mime()     -> [ { mimetypes, cow_mimetypes, all   } ].
% port()     -> [ { port, application:get_env(n2o,port,8000)  } ].
% points()   -> cowboy_router:compile([{'_', [
%     { "/web/[...]",          nitro_static,  static2()},
%     { "/ftp/[...]",          nitro_static,  n2o(application:get_env(roster,upload,"deps/n2o/priv")) },
%     { "/n2o/[...]",          nitro_static,  n2o("deps/n2o/priv") },
%     { "/bpe/[...]",          nitro_static,  n2o("deps/review/bpe") },
%     { "/ws/[...]",           n2o_stream,  []}, % FOR FTP
%     { "/[...]",              nitro_static,  static()},
%     { "/rest/:resource",     rest_cowboy, []},
%     { "/rest/:resource/:id", rest_cowboy, []} ]}]).

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
