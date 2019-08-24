defmodule REVIEW.Mixfile do
  use Mix.Project

  def project do
    [
     app: :review,
     version: "2.8.0",
     description: "N2O Sample Application",
     deps: deps(),
     docs: [],
     package: package()
    ]
  end

  defp package do
    [
     files: ~w(doc lib mix.exs LICENSE),
     licenses: ["ISC"],
     maintainers: ["Namdak Tonpa"],
     name: :review,
     links: %{"GitHub" => "https://github.com/synrc/review"}
    ]
   end

  defp deps do
     [
      {:ex_doc, "~> 0.20.2", only: :dev},
      {:emq_dashboard, github: "synrc/emq_dashboard"},
      {:n2o, "~> 6.5.0"},
      {:nitro, "~> 4.4.1"},
     ]
  end
end
