defmodule Hermes.JSONAPI.Link do
  defstruct href: nil, meta: %{}

  @type t :: %__MODULE__{
    href: nil | String.t,
    meta: %{}
  }

  def parse(link) when is_list(link), do: Enum.map(link, &parse(&1))
  def parse(link) when is_binary(link), do: parse(%{href: link})
  def parse(link) when is_map(link), do: struct(__MODULE__, link)
  def parse(link) when is_nil(link), do: nil
end
