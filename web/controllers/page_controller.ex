defmodule Ifcfg.PageController do
  use Ifcfg.Web, :controller
  require String
  require Logger

  def index(conn, _params) do
    remote_ip = conn.remote_ip |> Tuple.to_list |> Enum.join(".")
    user_agent = Plug.Conn.get_req_header(conn, "user-agent")
    Logger.info "#{remote_ip} : #{user_agent}"

    pattern = :binary.compile_pattern(["Firefox", "Chrome", "Safari"])
    if !String.contains?(to_string(user_agent), pattern) do
      text conn, remote_ip
    end

    render conn, "index.html", ip: remote_ip
  end
end
