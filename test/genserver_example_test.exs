defmodule GenExampleTest do
  use ExUnit.Case
  doctest GenExample

  test "greets the world" do
    assert GenExample.hello() == :world
  end
end
