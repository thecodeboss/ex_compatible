defmodule RenamedDefsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "Atom.to_charlist and Atom.to_char_list" do
    assert capture_io(:stderr, fn ->
      {'foo', _} = Code.eval_string("""
      import ExCompatible
      compatible(Atom.to_charlist(:foo))
      """)

      {'bar', _} = Code.eval_string("""
      import ExCompatible
      compatible(Atom.to_char_list(:bar))
      """)
    end) == ""
  end

  test "Float.to_charlist and Float.to_char_list" do
    assert capture_io(:stderr, fn ->
      {result, _} = Code.eval_string("""
      import ExCompatible
      compatible(Float.to_charlist(-2.7))
      """)
      assert List.to_float(result) == -2.7

      {result, _} = Code.eval_string("""
      import ExCompatible
      compatible(Float.to_char_list(1.99))
      """)
      assert List.to_float(result) == 1.99
    end) == ""
  end

  test "Integer.to_charlist and Integer.to_char_list" do
    assert capture_io(:stderr, fn ->
      {'-2', _} = Code.eval_string("""
      import ExCompatible
      compatible(Integer.to_charlist(-2))
      """)

      {'1', _} = Code.eval_string("""
      import ExCompatible
      compatible(Integer.to_char_list(1))
      """)
    end) == ""
  end

  test "Kernel.to_charlist and Kernel.to_char_list" do
    assert capture_io(:stderr, fn ->
      {'foo', _} = Code.eval_string("""
      import ExCompatible
      compatible(to_charlist(:foo))
      """)

      {'bar', _} = Code.eval_string("""
      import ExCompatible
      compatible(to_char_list(:bar))
      """)
    end) == ""
  end

  test "List.Chars.to_charlist and List.Chars.to_char_list" do
    assert capture_io(:stderr, fn ->
      {'Hello', _} = Code.eval_string("""
      import ExCompatible
      compatible(List.Chars.to_charlist("Hello"))
      """)

      {'foo', _} = Code.eval_string("""
      import ExCompatible
      compatible(List.Chars.to_char_list(:foo))
      """)
    end) == ""
  end

  test "String.to_charlist and String.to_char_list" do
    assert capture_io(:stderr, fn ->
      {'Hello', _} = Code.eval_string("""
      import ExCompatible
      compatible(String.to_charlist("Hello"))
      """)

      {'Hello', _} = Code.eval_string("""
      import ExCompatible
      compatible(String.to_char_list("Hello"))
      """)
    end) == ""
  end

  test "Enum.partition and Enum.split_with" do
    assert capture_io(:stderr, fn ->
      {result, _} = Code.eval_string("""
      import ExCompatible
      compatible do
        Enum.split_with([5, 4, 3, 2], fn(x) -> rem(x, 2) == 0 end)
      end
      """)
      assert result == {[4, 2], [5, 3]}

      {result, _} = Code.eval_string("""
      import ExCompatible
      compatible do
        Enum.partition([5, 4, 3, 2], fn(x) -> rem(x, 2) == 0 end)
      end
      """)
      assert result == {[4, 2], [5, 3]}
    end) == ""
  end

  test "String.trim and String.strip" do
    assert capture_io(:stderr, fn ->
      {"Hello", _} = Code.eval_string("""
      import ExCompatible
      compatible(String.trim("  \n Hello "))
      """)

      {"Hello", _} = Code.eval_string("""
      import ExCompatible
      compatible(String.strip("  \n Hello "))
      """)
    end) == ""
  end
end
