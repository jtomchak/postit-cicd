defmodule PostitCicd.Pipeline.BuildServer do
  use GenServer
  alias PostitCicd.Pipeline.Build

  def start_link(username) do
    name = build_tag(username)
    GenServer.start_link(__MODULE__, username, name: name)
  end

  def build_tag(username), do: :"username: #{username}"

  def create_build(username) do
    name = build_tag(username)
    GenServer.cast(name, {:create_build, username})
  end

  def get_build(username) do
    name = build_tag(username)
    GenServer.call(name, {:get})
  end

  # Callbacks 
  def init(username) do
    build = Build.new(username)
    {:ok, build}
  end

  # def handle_call({:add_question, question}, _from, poll) do
  #   poll = Poll.add_question(poll, question)
  #   {:reply, poll, poll}
  # end

  def handle_cast({:create_build, username}, state) do
    build = Build.create_build(username)
    {:noreply, state}
  end

  def handle_call({:get}, _from, build) do
    {:reply, build, build}
  end
end
