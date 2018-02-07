defmodule Inari.JSONAPI.ResourceSpec do
  use ESpec
  alias Inari.JSONAPI.Resource

  describe ".parse()" do
    context "on a list" do
      subject do: Resource.parse([%{id: "foo"}, %{id: "bar"}])
      it do: should eq [%Resource{id: "foo"}, %Resource{id: "bar"}]
    end

    context "on a map" do
      subject do: Resource.parse(%{id: "foo"})
      it do: should eq %Resource{id: "foo"}
    end

    context "on nil" do
      subject do: Resource.parse(nil)
      it do: should be_nil()
    end
  end
end
