defmodule Inari.Transform.FieldsSpec do
  @moduledoc false
  use ESpec, async: true
  alias Inari.Transform.Fields
  doctest Fields

  describe ".parse()" do
    context "on a map of fields params" do
      subject do: Fields.parse(%{kind: "foo,bar,baz", bar: "a,b,c"})
      it "should return a list of fragment nodes" do
        subject()
        |> Enum.each(fn({kind, name, arguments, children}) ->
          kind |> should(eq :fragment)
          name |> should(be_binary())
          arguments |> should(be_binary())
          children |> should(be_list())
        end)
      end
    end

    context "on string list of fields to include" do
      subject do: Fields.parse("foo,bar,baz")
      it "should return a list of field nodes with no alias or args" do
        subject()
        |> Enum.each(fn({kind, name, arguments, children}) ->
          kind |> should(eq :field)
          name |> should(be_binary())
          arguments |> should(match_pattern {nil, []})
          children |> should(be_empty())
        end)
      end
    end

    context "on nil" do
      subject do: Fields.parse(nil)
      it "should return an empty list" do
        should(be_list())
        should(be_empty())
      end
    end
  end
end
