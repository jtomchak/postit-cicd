defmodule PostitCicdWeb.BuildController do
  use PostitCicdWeb, :controller

  alias PostitCicd.Pipeline
  alias PostitCicd.Pipeline.Build

  action_fallback PostitCicdWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", builds: [])
  end

  def create(conn, %{"build" => %{"id" => id, "username" => username}}) do
    build = %{id: id, username: username}
    Build.create_build()
    render(conn, "show.json", build: build)
  end

  # def show(conn, %{"id" => id}) do
  #   build = Pipeline.get_build!(id)
  #   render(conn, "show.json", build: build)
  # end

  # def update(conn, %{"id" => id, "build" => build_params}) do
  #   build = Pipeline.get_build!(id)

  #   with {:ok, %Build{} = build} <- Pipeline.update_build(build, build_params) do
  #     render(conn, "show.json", build: build)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   build = Pipeline.get_build!(id)

  #   with {:ok, %Build{}} <- Pipeline.delete_build(build) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
