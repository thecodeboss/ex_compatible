# ExCompatible

ExCompatible strives to make your Elixir code compatible with as many Elixir
versions as possible, while reducing the number of compiler warnings.

Have you ever wanted to use `String.to_charlist/1`, but then your code no longer
compiles on Elixir 1.1? You switch to using `String.to_char_list/1` instead,
but now your compiler spits out annoying warnings on Elixir 1.5. What should
you do?

ExCompatible can inspect your Elixir version, and by using the `safe` macro, it
will always inject the most appropriate version of a defition so your compiler
stays happy.

## Usage

To add ExCompatible to your Elixir application, change the `deps` definition
in your `mix.exs` file:

```elixir
defp deps do
  [
    {:ex_compatible, "~> 0.1"}
  ]
end
```

Then you will need to import the `safe/1` macro inside any modules in which
you would like to use it. For example:

```elixir
defmodule MyModule do
  import ExCompatible, only: [safe: 1]

  def my_def do
    IO.puts safe(String.to_char_list("Hello world!"))

    safe do
      Enum.partition([5, 4, 3, 2], fn(x) -> rem(x, 2) == 0 end)
    end
  end
end
```

## Performance

ExCompatible is implemented using macros, which always inject the most
appropriate version of a given definition directly into the AST. This happens at
compile time, so at runtime there should be **zero** performance impact by
using ExCompatible.
