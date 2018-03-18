defmodule ExCompatible.Build do
  @moduledoc false

  @renames [
    # Deprecated in Elixir 1.6
    {{[:Enum], :partition}, {[:Enum], :split_with}, [2]},
    # Deprecated in Elixir 1.5
    {{[:Atom], :to_char_list}, {[:Atom], :to_charlist}, [1]},
    {{[:Float], :to_char_list}, {[:Float], :to_charlist}, [1]},
    {{[:Integer], :to_char_list}, {[:Integer], :to_charlist}, [1, 2]},
    {{[:Kernel], :to_char_list}, {[:Kernel], :to_charlist}, [1]},
    {{[:List, :Chars], :to_char_list}, {[:List, :Chars], :to_charlist}, [1]},
    {{[:String], :to_char_list}, {[:String], :to_charlist}, [1]},
    {{[:String], :strip}, {[:String], :trim}, [1, 2]},
  ]

  defmacro __before_compile__(_env) do
    defs =
      for {old, new, arities} <- @renames do
        {old_module, old_def} = old
        {new_module, new_def} = new
        expression = choose_expression(old, new, arities)

        quote do
          def make_safe(unquote(call_expression(old_module, old_def))) do
            unquote(expression)
          end

          def make_safe(unquote(call_expression(new_module, new_def))) do
            unquote(expression)
          end
        end
      end

    quote do
      @doc false
      @spec make_safe(Macro.t()) :: Macro.t()
      unquote_splicing(defs)

      def make_safe({call, ctx, args})
          when call in [:to_charlist, :to_char_list] do
        unquote(
          if macro_exported?(Kernel, :to_charlist, 1) do
            quote(do: {:to_charlist, ctx, args})
          else
            quote(do: {:to_char_list, ctx, args})
          end
        )
      end

      def make_safe(quoted) do
        quoted
      end
    end
  end

  defp call_expression(module, def_name) do
    quote do
      {:., meta1, [{:__aliases__, meta2, unquote(module)}, unquote(def_name)]}
    end
  end

  defp choose_expression(old, new, arities) do
    {old_module, old_def,} = old
    {new_module, new_def} = new

    [arity | _] = arities
    new_elixir_module = Module.concat(new_module)

    case Code.ensure_loaded(new_elixir_module) do
      {:module, module} ->
        if function_exported?(module, new_def, arity) do
          call_expression(new_module, new_def)
        else
          call_expression(old_module, old_def)
        end
      _ ->
        call_expression(old_module, old_def)
    end
  end
end
