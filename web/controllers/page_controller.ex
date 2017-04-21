defmodule Ifcfg.PageController do
  use Ifcfg.Web, :controller
  require String
  require Logger

  def index(conn, _params) do
    remote_ips = Plug.Conn.get_req_header(conn, "x-forwarded-for")
    remote_ip = List.first(remote_ips)
    unless remote_ip do
      remote_ip_as_tuple = conn.remote_ip
      remote_ip = Enum.join(Tuple.to_list(remote_ip_as_tuple), ".")
    end

    user_agent = Plug.Conn.get_req_header(conn, "user-agent")
    Logger.info "#{remote_ip} : #{user_agent}"

    pattern = :binary.compile_pattern(["Firefox", "Chrome", "Safari"])
    if !String.contains?(to_string(user_agent), pattern) do
      text conn, remote_ip
    end

    render conn, "index.html", ip: remote_ip
  end
end
