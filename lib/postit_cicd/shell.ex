defmodule PostitCicd.Shell do
  def exec(exe, args, opts \\ [:stream]) when is_list(args) do
    port =
      Port.open(
        {:spawn_executable, exe},
        opts ++ [{:args, args}, :binary, :exit_status, :hide, :use_stdio, :stderr_to_stdout]
      )

    handle_output(port)
  end

  def handle_output(port) do
    receive do
      {^port, {:data, data}} ->
        # Replace this with the appropriate broadcast
        IO.inspect(data)
        handle_output(port)

      {^port, {:exit_status, status}} ->
        status
    end
  end
end
