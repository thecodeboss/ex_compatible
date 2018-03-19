ExCompatible
============

[![Build Status](https://travis-ci.org/thecodeboss/ex_compatible.svg?branch=master)](https://travis-ci.org/thecodeboss/ex_compatible)
[![Coverage Status](https://coveralls.io/repos/github/thecodeboss/ex_compatible/badge.svg?branch=master)](https://coveralls.io/github/thecodeboss/ex_compatible?branch=master)
[![Hex.pm version](https://img.shields.io/hexpm/v/ex_compatible.svg?style=flat-square)](https://hex.pm/packages/ex_compatible)
[![Hex.pm downloads](https://img.shields.io/hexpm/dt/ex_compatible.svg?style=flat-square)](https://hex.pm/packages/ex_compatible)
[![License](https://img.shields.io/hexpm/l/ex_compatible.svg?style=flat-square)](https://hex.pm/packages/ex_compatible)
[![Docs](https://img.shields.io/badge/api-docs-yellow.svg?style=flat)](http://hexdocs.pm/ex_compatible/)

ExCompatible strives to make your Elixir code compatible with as many Elixir
versions as possible, while reducing the number of compiler warnings.

See [http://hexdocs.pm/ex_compatible/](http://hexdocs.pm/ex_compatible/) for
documentation,
 [https://github.com/kafkaex/ex_compatible/](https://github.com/kafkaex/ex_compatible/)
 for code.

Have you ever wanted to use `String.to_charlist/1`, but then your code no longer
compiles on Elixir 1.1? You switch to using `String.to_char_list/1` instead,
but now your compiler spits out annoying warnings on Elixir 1.5. What should
you do?

ExCompatible can inspect your Elixir version, and by using the `compatible`
macro, it will always inject the most appropriate version of a defition so your
compiler stays happy.

**Note:** This project is still under heavy construction. Please check the to-do
list further down, and we love contributors!

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

Then you will need to import the `compatible/1` macro inside any modules in
which you would like to use it. For example:

```elixir
defmodule MyModule do
  import ExCompatible, only: [compatible: 1]

  def my_def do
    IO.puts compatible(String.to_char_list("Hello world!"))

    compatible do
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

## To-do

There are lots of different types of deprecations, ranging from simple renames,
to spec changes, complete removal, or splits into multiple functions. The goal
is to be able to handle all of these different types, and to do that we'll need
a checklist.

### Elixir 1.6 Deprecations

- [x] `Enum.partition/2`
- [ ] `Keyword.replace/3`
- [ ] `Macro.unescape_tokens/1` and `Macro.unescape_tokens/2`
- [ ] `Module.add_doc/6`
- [ ] `Map.replace/3`
- [ ] `Range.range?/1`

### Elixir 1.5 Deprecations

- [x] `Atom.to_char_list/1`
- [ ] `Enum.filter_map/3`
- [x] `Float.to_char_list/1`
- [ ] `GenEvent` module
- [x] `Integer.to_char_list/1` and `Integer.to_char_list/2`
- [x] `Kernel.to_char_list/1`
- [x] `List.Chars.to_char_list/1`
- [ ] `Stream.filter_map/3`
- [ ] `String.ljust/3` and `String.rjust/3`
- [x] `String.strip/1` and `String.strip/2`
- [ ] `String.lstrip/1` and `String.rstrip/1`
- [ ] `String.lstrip/2` and `String.rstrip/2`
- [x] `String.to_char_list/1`
- [ ] `()` to mean `nil`
- [ ] `:as_char_lists` value in `t:Inspect.Opts.t/0` type
- [ ] `:char_lists` key in `t:Inspect.Opts.t/0` type
- [ ] `char_list/0` type
- [ ] `@compile {:parse_transform, _}` in `Module`
- [ ] EEx: `<%=` in middle and end expressions

### Elixir 1.4 Deprecations

- [ ] `Access.key/1`
- [ ] `Behaviour` module
- [ ] `Enum.uniq/2`
- [ ] `Float.to_char_list/2`
- [ ] `Float.to_string/2`
- [ ] `HashDict` module
- [ ] `HashSet` module
- [ ] `Set` module
- [ ] `Stream.uniq/2`
- [ ] `IEx.Helpers.import_file/2`
- [ ] `Mix.Utils.camelize/1`
- [ ] `Mix.Utils.underscore/1`
- [ ] Variable used as function call
- [ ] Anonymous functions with no expression after `->`

### Elixir 1.3 Deprecations

- [ ] `Dict` module
- [ ] `Keyword.size/1`
- [ ] `Map.size/1`
- [ ] `Set` behaviour
- [ ] `String.valid_character?/1`
- [ ] `Task.find/2`
- [ ] `:append_first` option in `Kernel.defdelegate/2`
- [ ] `/r` option in `Regex`
- [ ] `\x{X*}` inside strings/sigils/charlists
- [ ] Map or dictionary as second argument in `Enum.group_by/3`
- [ ] Non-map as second argument in `URI.decode_query/2`

### Elixir 1.2 Deprecations

- [ ] `Dict` behaviour

### Elixir 1.1 Deprecations

- [ ] `Access` protocol
- [ ] `as: true \| false` in `alias/2` and `require/2`
- [ ] `?\xHEX`
