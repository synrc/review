defmodule Review.MixProject do
 use Mix.Project

 def project do
    [
      app: :review,
      version: "4.11.0",
      description: "REVIEW TT Sample N2O/MQTT Application",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      erlc_paths: ["src"],
      deps: deps()
    ]
 end

 def application do
    [
      mod: {Review.App, []},
      applications: [
        :mnesia,
        :syn,
        :kvs,
        :emqx,
        :emqtt,
        :nitro,
        :n2o
      ]
    ]
 end

 def deps do
  [
    {:cowlib, "~> 2.9.1", override: true},
    {:cowboy, "~> 2.8.0", override: true},
    {:ranch,  "~> 1.7.1", override: true},
    {:n2o,    "~> 8.8.1", override: true},
    {:syn,    "~> 2.1.1", override: true},
    {:kvs,    "~> 8.10.4", override: true},
    {:rpc,    "~> 3.1.1", override: true},
    {:nitro,  "~> 6.11.6", override: true},
    {:getopt, github: "xio/getopt", ref: "master", override: true},
    {:emqx,   github: "xio/emqx",   ref: "erp.uno"},
    {:emqtt,  github: "xio/emqtt",  ref: "master"},
  ]
 end
end
