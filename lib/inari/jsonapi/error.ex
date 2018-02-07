defmodule Inari.JSONAPI.Error do
  @moduledoc """
  Structure which represents a JSONAPI Error object
  """
  defstruct id: nil, links: nil, status: nil, code: nil, title: nil, detail: nil, source: nil,
    meta: nil

  @type t :: %__MODULE__{
    id: nil | String.t,
    links: nil | [Inari.JSONAPI.Link.t],
    status: nil | String.t,
    code: nil | String.t,
    title: nil | String.t,
    detail: nil | String.t,
    source: nil | %{},
    meta: nil | %{}
  }

  def parse(error) when is_list(error), do: Enum.map(error, &__MODULE__.parse(&1))
  def parse(error) when is_map(error), do: struct(__MODULE__, error)
  def parse(error) when is_nil(error), do: nil
end
