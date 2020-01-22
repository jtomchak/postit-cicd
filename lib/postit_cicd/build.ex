defmodule PostitCicd.Pipeline.Build do
  alias __MODULE__
  alias PostitCicd.Shell

  defstruct(
    id: nil,
    username: ""
  )

  def create_build() do
    lscmd = System.find_executable("ls")

    Shell.exec(lscmd, ["-als"], [
      {:line, 4096}
    ])
  end
end
