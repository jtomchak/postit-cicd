defmodule PostitCicd.Pipeline.BuildServer do
  use GenServer
  import Logger
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

  def handle_call({:get}, _from, build) do
    {:reply, build, build}
  end

  # update server log from build stout output
  def handle_info({port, {:data, text_line}}, state) do
    {:noreply, %Build{state | log: [text_line | state.log]}}
  end

  def handle_cast({:create_build, username}, state) do
    build = Build.create_build(state)
    {:noreply, build}
  end

  # This callback tells us when the process exits
  def handle_info({port, {:exit_status, status}}, state) do
    Logger.info("External exit: :exit_status: #{status}")

    new_state = Build.complete_build(state)
    {:noreply, new_state}
  end

  # no-op catch-all callback for unhandled messages
  def handle_info(_msg, state), do: {:noreply, state}
end
