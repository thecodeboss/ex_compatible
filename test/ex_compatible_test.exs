defmodule ExCompatibleTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "String.to_charlist and String.to_char_list" do
    assert capture_io(:stderr, fn ->
      {'Hello', _} = Code.eval_string("""
      import ExCompatible
      safe(String.to_charlist("Hello"))
      """)
    end) == ""

    assert capture_io(:stderr, fn ->
      {'Hello', _} = Code.eval_string("""
      import ExCompatible
      safe(String.to_char_list("Hello"))
      """)
    end) == ""
  end

  test "Enum.partition and Enum.split_with" do
    assert capture_io(:stderr, fn ->
      {result, _} = Code.eval_string("""
      import ExCompatible
      safe do
        Enum.split_with([5, 4, 3, 2], fn(x) -> rem(x, 2) == 0 end)
      end
      """)
      assert result == {[4, 2], [5, 3]}
    end) == ""

    assert capture_io(:stderr, fn ->
      {result, _} = Code.eval_string("""
      import ExCompatible
      safe do
        Enum.partition([5, 4, 3, 2], fn(x) -> rem(x, 2) == 0 end)
      end
      """)
      assert result == {[4, 2], [5, 3]}
    end) == ""
  end
end
