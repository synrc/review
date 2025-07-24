-module(msg).
-compile(export_all).
-include_lib("kvs/include/metainfo.hrl").

metainfo() -> #schema { name = msg, tables = tables() }.
tables() -> [ #table  { name = msg, fields = [seq,user,data], instance = {msg,0,[],[]} } ].

