defmodule PostitCicd.Pipeline.Build do
  alias __MODULE__
  alias PostitCicd.Shell

  defstruct(username: "")

  def new(username) do
    %Build{
      username: username
    }
  end

  # docker run -it --rm -e GOOGLE_ACCOUNT_KEY="$(< ~/.gcloud/keyfile.json)" -e GOOGLE_PROJECT_ID=post-it-services -e USERNAME=jesse postit/ci:latest
  # 
  def create_build(username) do
    dockercmd = System.find_executable("docker")
    authfile = File.read!("../keyfile.json")

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
        "USERNAME=#{username}",
        "jtomchak/postitci:1.0.0"
      ],
      [
        {:line, 4096}
      ]
    )
  end
end
