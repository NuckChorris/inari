defmodule Hermes.Endpoint do
  use Plug.Builder
  use Plug.Debugger
  import Plug.Conn

  plug Plug.RequestId
  plug Plug.Logger
  plug Plug.Head

  plug Plug.Parsers, parsers: [:json], pass: ["application/vnd.api+json"], json_decoder: Poison
  plug Hermes.Utils.Accepts, type: "application/vnd.api+json"

  plug :parse_jsonapi

  @doc """
  Parses a json:api request into an IR
  """
  @spec parse_jsonapi(conn :: %Plug.Conn{}, _opts :: %{}) :: %Plug.Conn{}
  def parse_jsonapi(conn, _opts) do
    IO.inspect(conn.req_headers)
    conn |> send_resp(:ok, "{}")
  end

  @spec issue_graphql(conn :: %Plug.Conn{}, _opts :: %{}) :: %Plug.Conn{}
  def issue_graphql(conn, _opts) do
    conn
  end
end
