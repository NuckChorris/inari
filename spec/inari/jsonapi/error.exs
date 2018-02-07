defmodule Inari.JSONAPI.ErrorSpec do
  use ESpec
  alias Inari.JSONAPI.Error

  describe ".parse()" do
    context "on a list" do
      subject do: Error.parse([%{id: "foo"}, %{id: "bar"}])
      it do: should eq [%Error{id: "foo"}, %Error{id: "bar"}]
    end

    context "on a map" do
      subject do: Error.parse(%{id: "foo"})
      it do: should eq %Error{id: "foo"}
    end

    context "on nil" do
      subject do: Error.parse(nil)
      it do: should be_nil()
    end
  end
end
