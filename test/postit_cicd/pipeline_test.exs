defmodule PostitCicd.PipelineTest do
  use PostitCicd.DataCase

  alias PostitCicd.Pipeline

  describe "builds" do
    alias PostitCicd.Pipeline.Build

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def build_fixture(attrs \\ %{}) do
      {:ok, build} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pipeline.create_build()

      build
    end

    test "list_builds/0 returns all builds" do
      build = build_fixture()
      assert Pipeline.list_builds() == [build]
    end

    test "get_build!/1 returns the build with given id" do
      build = build_fixture()
      assert Pipeline.get_build!(build.id) == build
    end

    test "create_build/1 with valid data creates a build" do
      assert {:ok, %Build{} = build} = Pipeline.create_build(@valid_attrs)
    end

    test "create_build/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pipeline.create_build(@invalid_attrs)
    end

    test "update_build/2 with valid data updates the build" do
      build = build_fixture()
      assert {:ok, %Build{} = build} = Pipeline.update_build(build, @update_attrs)
    end

    test "update_build/2 with invalid data returns error changeset" do
      build = build_fixture()
      assert {:error, %Ecto.Changeset{}} = Pipeline.update_build(build, @invalid_attrs)
      assert build == Pipeline.get_build!(build.id)
    end

    test "delete_build/1 deletes the build" do
      build = build_fixture()
      assert {:ok, %Build{}} = Pipeline.delete_build(build)
      assert_raise Ecto.NoResultsError, fn -> Pipeline.get_build!(build.id) end
    end

    test "change_build/1 returns a build changeset" do
      build = build_fixture()
      assert %Ecto.Changeset{} = Pipeline.change_build(build)
    end
  end

  describe "builds" do
    alias PostitCicd.Pipeline.Build

    @valid_attrs %{id: 42, username: "some username"}
    @update_attrs %{id: 43, username: "some updated username"}
    @invalid_attrs %{id: nil, username: nil}

    def build_fixture(attrs \\ %{}) do
      {:ok, build} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pipeline.create_build()

      build
    end

    test "list_builds/0 returns all builds" do
      build = build_fixture()
      assert Pipeline.list_builds() == [build]
    end

    test "get_build!/1 returns the build with given id" do
      build = build_fixture()
      assert Pipeline.get_build!(build.id) == build
    end

    test "create_build/1 with valid data creates a build" do
      assert {:ok, %Build{} = build} = Pipeline.create_build(@valid_attrs)
      assert build.id == 42
      assert build.username == "some username"
    end

    test "create_build/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pipeline.create_build(@invalid_attrs)
    end

    test "update_build/2 with valid data updates the build" do
      build = build_fixture()
      assert {:ok, %Build{} = build} = Pipeline.update_build(build, @update_attrs)
      assert build.id == 43
      assert build.username == "some updated username"
    end

    test "update_build/2 with invalid data returns error changeset" do
      build = build_fixture()
      assert {:error, %Ecto.Changeset{}} = Pipeline.update_build(build, @invalid_attrs)
      assert build == Pipeline.get_build!(build.id)
    end

    test "delete_build/1 deletes the build" do
      build = build_fixture()
      assert {:ok, %Build{}} = Pipeline.delete_build(build)
      assert_raise Ecto.NoResultsError, fn -> Pipeline.get_build!(build.id) end
    end

    test "change_build/1 returns a build changeset" do
      build = build_fixture()
      assert %Ecto.Changeset{} = Pipeline.change_build(build)
    end
  end
end
