defmodule Hermes.Utils.PathParserSpec do
  use ESpec
  alias Hermes.Utils.PathParser

  describe ".parse(url)" do
    context "for /users/1/relationships/likes" do
      subject(do: PathParser.parse("/users/1/relationships/likes"))
      it(do: should(eq({:relationship, {"users", "1", "likes"}})))
    end

    context "for /users/1/likes" do
      subject(do: PathParser.parse("/users/1/likes"))
      it(do: should(eq({:related, {"users", "1", "likes"}})))
    end

    context "for /users/1" do
      subject(do: PathParser.parse("/users/1"))
      it(do: should(eq({:instance, {"users", "1"}})))
    end

    context "for /users" do
      subject(do: PathParser.parse("/users"))
      it(do: should(eq({:model, {"users"}})))
    end
  end
end
