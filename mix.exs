defmodule Review.MixProject do
 use Mix.Project

 def project do
    [
      app: :review,
      version: "1.2.0",
      description: "Review",
      elixir: "~> 1.10",
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
        :xio,
        :nitro,
        :n2o
      ]
    ]
 end

 def deps do
  [
    {:syn, github: "ostinelli/syn", ref: "2.1.1", override: true},  # {:syn, "~> 2.1.1", override: true},
    {:kvs, github: "synrc/kvs", ref: "7.9.1", override: true},      # {:kvs, "~> 7.9.1", override: true},
    {:getopt, github: "xio/getopt", ref: "master", override: true},
    {:cowlib, "~> 2.9.1", override: true},
    {:cowboy, "~> 2.8.0", override: true},
    {:xio, github: "erpuno/xio", ref: "v4.2"},
    {:emqtt, "~> 1.2"},
    {:n2o, github: "synrc/n2o", ref: "master", override: true},    # {:n2o, "~> 7.10.0"}
    {:nitro, github: "synrc/nitro", ref: "master", override: true}, # {:nitro, "~> 5.9.1", override: true}
  ]
 end
end
