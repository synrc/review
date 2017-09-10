defmodule FS.Mixfile do
  use Mix.Project

  def project do
    [app: :review,
     version: "3.4",
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
     [{:ex_doc, ">= 0.0.0", only: :dev}]
  end
end
