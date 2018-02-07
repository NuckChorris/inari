defmodule Inari.Utils.PathParser do
  @spec parse(String.t()) :: {atom, tuple()}
  def parse(path) do
    ["" | path] = String.split(path, "/")
    path |> do_parse
  end

  defp do_parse([resource, number, "relationships", relationship]) do
    {:relationship, {resource, number, relationship}}
  end

  defp do_parse([resource, number, relationship]) do
    {:related, {resource, number, relationship}}
  end

  defp do_parse([resource, number]) do
    {:instance, {resource, number}}
  end

  defp do_parse([resource]) do
    {:model, {resource}}
  end
end
