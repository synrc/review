defmodule FS.Mixfile do
  use Mix.Project

  def project do
    [app: :review,
     version: "1.10",
     description: "N2O Sample Application",
     deps: deps,
     docs: [],
     package: package]
  end

  defp package do
    [name: :review,
     files: ["include", "n2o", "src", "back.jpg", "S.svg", "index.htm", "login.htm", "synrc.css"],
     maintainers: ["Arseniy Bushyn", "Namdak Tonpa"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/synrc/review"}]
   end

  defp deps do
     [{:kvs, ">= 0.0.0"}]
     [{:n2o, ">= 0.0.0"}]
     [{:active, "== 1.9"}]
     [{:cowboy, "== 1.0.1"}]
     [{:nitro, ">= 0.0.0"}]
     [{:mad, ">= 0.0.0"}]
     [{:ex_doc, ">= 0.0.0", only: :dev}]
  end
end
