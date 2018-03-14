defmodule Inari.Transform.Fields do
  @moduledoc """
  Manages the conversion from json:api's fields[] params into a set of GraphQL fragments, which are
  internally represented as an AST.
  """
  import Inflex

  def parse(map) when is_map(map) do
    map
    |> Map.to_list
    |> Enum.map(fn({kind, fields}) ->
      kind = Atom.to_string(kind)
      {:fragment, kind <> "Fields", camelize(kind), parse(fields)}
    end)
  end
  def parse(str) when is_binary(str) do
    str
    |> String.split(",")
    |> Enum.map(fn(field_name) ->
      {:field, field_name, {nil, []}, []}
    end)
  end
  def parse(nil), do: []
end
