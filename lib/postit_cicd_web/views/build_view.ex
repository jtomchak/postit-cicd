defmodule PostitCicdWeb.BuildView do
  import Logger
  use PostitCicdWeb, :view
  alias PostitCicdWeb.BuildView

  def render("index.json", %{builds: builds}) do
    %{data: render_many(builds, BuildView, "build.json")}
  end

  def render("show.json", %{build: build}) do
    %{data: render_one(build, BuildView, "build.json")}
  end

  def render("build.json", %{build: build}) do
    %{id: build.id, username: build.username}
  end
end
