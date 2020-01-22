defmodule PostitCicdWeb.BuildControllerTest do
  use PostitCicdWeb.ConnCase

  alias PostitCicd.Pipeline
  alias PostitCicd.Pipeline.Build

  @create_attrs %{
    id: 42,
    username: "some username"
  }
  @update_attrs %{
    id: 43,
    username: "some updated username"
  }
  @invalid_attrs %{id: nil, username: nil}

  def fixture(:build) do
    {:ok, build} = Pipeline.create_build(@create_attrs)
    build
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all builds", %{conn: conn} do
      conn = get(conn, Routes.build_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create build" do
    test "renders build when data is valid", %{conn: conn} do
      conn = post(conn, Routes.build_path(conn, :create), build: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.build_path(conn, :show, id))

      assert %{
               "id" => id,
               "id" => 42,
               "username" => "some username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.build_path(conn, :create), build: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update build" do
    setup [:create_build]

    test "renders build when data is valid", %{conn: conn, build: %Build{id: id} = build} do
      conn = put(conn, Routes.build_path(conn, :update, build), build: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.build_path(conn, :show, id))

      assert %{
               "id" => id,
               "id" => 43,
               "username" => "some updated username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, build: build} do
      conn = put(conn, Routes.build_path(conn, :update, build), build: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete build" do
    setup [:create_build]

    test "deletes chosen build", %{conn: conn, build: build} do
      conn = delete(conn, Routes.build_path(conn, :delete, build))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.build_path(conn, :show, build))
      end
    end
  end

  defp create_build(_) do
    build = fixture(:build)
    {:ok, build: build}
  end
end
