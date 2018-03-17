defmodule ExCompatible.Build do
  @moduledoc false

  @deprecations [
    {{:String, :to_char_list, 1}, {:String, :to_charlist, 1}},
    {{:Enum, :partition, 2}, {:Enum, :split_with, 2}}
  ]

  defmacro __before_compile__(_env) do
    defs =
      for {old, new} <- @deprecations do
        {old_module, old_def, _old_arity} = old
        {new_module, new_def, _new_arity} = new
        expression = choose_expression(old, new)

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

      def make_safe(quoted) do
        quoted
      end
    end
  end

  defp call_expression(module, def_name) do
    quote do
      {:., meta1, [{:__aliases__, meta2, [unquote(module)]}, unquote(def_name)]}
    end
  end

  defp choose_expression(old, new) do
    {old_module, old_def, _old_arity} = old
    {new_module, new_def, new_arity} = new

    if function_exported?(:"Elixir.#{new_module}", new_def, new_arity) do
      call_expression(new_module, new_def)
    else
      call_expression(old_module, old_def)
    end
  end
end
