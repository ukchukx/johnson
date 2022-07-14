defmodule JohnsonTest do
  use ExUnit.Case
  doctest Johnson

  @str ~s({"a":"a","b":"b"})
  @json %Johnson{data: [{"a", "a"}, {"b", "b"}]}

  test "decoding" do
    assert Johnson.decode!(@str) == @json
  end

  test "encoding" do
    assert Johnson.encode!(@json) == @str
  end

  test "fetching fields" do
    assert Johnson.get(@json, "a") == "a"
  end
end
