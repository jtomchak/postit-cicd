defmodule PostitCicd.Pipeline.Build do
  alias __MODULE__
  alias PostitCicd.Shell

  @external_resource "priv/dockerbuild.sh"
  @dockerbuild_contents File.read!("priv/dockerbuild.sh")
  def dockerbuild_contents, do: @dockerbuild_contents

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
    dockercmd = System.find_executable("docker")

    Shell.exec(
      dockercmd,
      [
        "run",
        "--rm",
        "-e",
        "GOOGLE_ACCOUNT_KEY=#{authfile}",
        "-e",
        "GOOGLE_PROJECT_ID=post-it-services",
        "-e",
        "USERNAME=#{build.username}",
        "jtomchak/postitci:latest"
      ],
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
