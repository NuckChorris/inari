defmodule Inari.Plug.Accepts do
  @behaviour Plug

  import Plug.Conn
  alias Plug.Conn.Utils

  def init(opts), do: opts

  def call(conn, opts) do
    if accepts_content_type?(conn, opts[:type]) do
      conn
    else
      conn
      |> put_resp_content_type(opts[:type])
      |> send_resp(:not_acceptable, "{}")
    end
  end

  defp accepts_content_type?(conn, type) do
    type = Utils.content_type(type)

    conn
    |> get_accepted_types
    |> Enum.any?(fn accepted -> accepted == type end)
  end

  defp get_accepted_types(conn) do
    conn
    |> get_req_header("accept")
    |> Enum.flat_map(&Utils.list/1)
    |> Enum.map(&Utils.media_type/1)
  end
end
