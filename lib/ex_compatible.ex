defmodule ExCompatible do
  @moduledoc """
  ExCompatible strives to make your Elixir code compatible with as many Elixir
  versions as possible, while reducing the number of compiler warnings.
  """
  require ExCompatible.Build
  @before_compile ExCompatible.Build

  @doc """
  Ensures the given expression will be compatible across all Elixir versions.

  ## Examples

      safe(String.to_char_list("Hello"))

      safe do
        String.to_char_list("Hello")
      end
  """
  defmacro safe(do: quoted) do
    Macro.postwalk(quoted, &make_safe/1)
  end

  defmacro safe(quoted) do
    Macro.postwalk(quoted, &make_safe/1)
  end
end
