defmodule Review.MixProject do
 use Mix.Project

 def project do
    [
      app: :review,
      version: "4.11.0",
      description: "Telemetry Transport Sample Application",
      deps: deps()
    ]
 end

 def application do
    [
      mod: {Review.App, []},
      extra_applications: [:crypto, :bandit, :mnesia, :kvs, :n2o, :nitro, :ranch, :cowboy, :telemetry, :plug],
      applications: [:gproc, :syn, :emqttd, :emq_dashboard]
    ]
 end

 def deps do
  [
    {:ex_doc, "~> 0.29.0", only: :dev},
    {:cowlib, "~> 2.15.0", override: true},
    {:cowboy, "~> 2.13.0", override: true},
    {:emqtt,  "~> 1.11.0"},
    {:plug, "~> 1.15.3"},
    {:bandit, "~> 1.0"},
    {:websock_adapter, "~> 0.5"},
    {:n2o,    "~> 11.9.6"},
    {:kvs,    "~> 11.9.1", override: true},
    {:syn,    "~> 2.1.1"},
    {:nitro,  "~> 9.9.6"},
    {:emq_dashboard, github: "skynet64/emq_dashboard", ref: "master", override: true},
    {:emqttd, github: "skynet64/emqttd", ref: "master", override: true},
    {:emqttc, github: "skynet64/emqttc", ref: "master", override: true}
  ]
 end
end
