defmodule Hermes.JSONAPI.Resource do
  @moduledoc """
  Structure which represents an object in JSONAPI
  """
  defstruct id: nil, type: nil, attributes: %{}, relationships: %{}, links: %{}, meta: %{}

  alias Hermes.JSONAPI, as: J

  @type t :: %__MODULE__{
    id: nil | String.t,
    type: String.t,
    attributes: %{},
    relationships: %{String.t => J.Relationship.t},
    links: %{String.t => J.Link.t},
    meta: %{}
  }

  @spec parse([%{}]) :: [J.Resource.t]
  def parse(docs) when is_list(docs), do: Enum.map(docs, &__MODULE__.parse(&1))
  @spec parse(%{}) :: J.Resource.t
  def parse(doc) when is_map(doc), do: struct(__MODULE__, doc)
  @spec parse(nil) :: nil
  def parse(doc) when is_nil(doc), do: nil
end
