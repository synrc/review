defmodule Review.App do
   use Application
   use Supervisor
   require KVS

   def mime(), do: [{:mimetypes, :cow_mimetypes, :all}]
   def points() do
    :cowboy_router.compile([
      {:_,
       [
         {'/',            :cowboy_static, {:file, "priv/static/index.html", mime()}},
         {'/ws/[...]',    :n2o_cowboy, []},
         {'/n2o/[...]',   :cowboy_static, {:dir, "deps/n2o/priv", mime()}},
         {'/nitro/[...]', :cowboy_static, {:dir, "deps/nitro/priv/js",  mime()}},
         {'/[...]',       :cowboy_static, {:dir, "priv/static", mime()}}
       ]}
    ])
   end

   def env(),  do: %{env: %{dispatch: points()}}
   def trans(),do: [{:port, :application.get_env(:n2o, :port, 8000)}]
   def spec(), do: :ranch.child_spec(:http, 100, :ranch_tcp, trans(), :cowboy_clear, env())

   @impl true
   def init([]) do
      :kvs.join([],KVS.kvs(mod: :kvs_mnesia))
      :n2o.start_mqtt()
      Supervisor.init([spec()], strategy: :one_for_one)
   end

   @impl true
   def start(_,arg), do: Supervisor.start_link(__MODULE__, arg, name: __MODULE__)

end
