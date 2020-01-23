defmodule PostitCicd.Pipeline.BuildSupervisor do
  use DynamicSupervisor
  alias PostitCicd.Pipeline.BuildServer

  # args as a list
  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def start_build(username) do
    spec = {BuildServer, username}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  # callbacks

  def init(_args), do: DynamicSupervisor.init(strategy: :one_for_one)
end
