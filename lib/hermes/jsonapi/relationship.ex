defmodule Hermes.JSONAPI.Relationship do
  @moduledoc """
  Structure which represents a relationship in JSONAPI
  """
  defstruct links: nil, data: nil, meta: nil

  alias Hermes.JSONAPI, as: J

  @type t :: %__MODULE__{
    links: nil | %{optional(:self) => String.t, optional(:related) => String.t},
    data: nil | %{type: String.t, id: String.t},
    meta: %{}
  }
end
