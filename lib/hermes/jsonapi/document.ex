defmodule Hermes.JSONAPI.Document do
  @moduledoc """
  Structure which represents an entire JSONAPI document
  """
  defstruct data: nil, errors: nil, meta: nil, jsonapi: nil, links: nil, included: nil

  alias Hermes.JSONAPI, as: J

  @type t :: %__MODULE__{
    data: nil | J.Resource.t | [J.Resource.t],
    errors: nil | [J.Error.t],
    meta: nil | %{},
    jsonapi: nil | %{},
    links: nil | %{required(String.t) => J.Link.t},
    included: nil | [J.Resource.t]
  }

  def parse(str) do
    Poison.decode(str, as: %__MODULE__{})
  end

  defimpl Poison.Decoder do
    def decode(doc, _options) do
      %{doc |
        data: J.Resource.parse(doc.data),
        links: J.Link.parse(doc.links),
        included: J.Resource.parse(doc.data),
        errors: J.Error.parse(doc.errors)
      }
    end
  end
end
