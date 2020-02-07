defmodule PostitCicd.Pipeline.Build do
  alias __MODULE__
  alias PostitCicd.Shell

  defstruct(username: "", status: "", log: [])

  def new(username) do
    %Build{
      username: username,
      status: "Ready"
    }
  end

  # docker run -it --rm -e GOOGLE_ACCOUNT_KEY="$(< ~/.gcloud/keyfile.json)" -e GOOGLE_PROJECT_ID=post-it-services -e USERNAME=jesse postit/ci:latest
  # 
  def create_build(build) do
    authfile = File.read!("../keyfile.json")

    dockerbuildcmd =
      System.cwd()
      |> Path.join("bin/dockerbuild.sh")

    Shell.exec(
      dockerbuildcmd,
      [authfile, build.username],
      [
        {:line, 4096}
      ]
    )

    # return updated build struct
    %Build{build | status: "Running"}
  end

  def complete_build(build) do
    %Build{build | status: "Ready"}
  end
end
