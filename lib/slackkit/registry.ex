defmodule Slackkit.Registry do
  @moduledoc false

  defmodule Registry do
    @moduledoc false
    defmacro __before_compile__(_) do
      quote do
        # def unquote(Module.get_attribute(__CALLER__.module, :registry_name))() do
        #   unquote(Module.get_attribute(__CALLER__.module, Module.get_attribute(__CALLER__.module, :registry_name)))
        # end
      end
    end
  end

  defmacro __using__([]), do: raise ArgumentError, "must name this registry"
  defmacro __using__(name) do
    quote do
      defmacro __using__(_) do
        name = unquote(name)
        quote do
          # @before_compile Registry
          @registry_name unquote(name)
          Module.register_attribute(__MODULE__, @registry_name, accumulate: true)
          Module.put_attribute(__MODULE__, @registry_name, unquote(__MODULE__))
        end
      end
    end
  end

end

# defmodule Slackkit.Registry.Extended do
#
#   defmacro __using__([]) do
#     raise ArgumentError, "must provide a registry name"
#   end
#
#   defmacro __using__(registry) do
#     quote location: :keep do
#
#       defmacro __using__(_) do
#         registry = unquote(registry)
#         quote location: :keep do
#
#           defmacro __using__([]) do
#             raise ArgumentError, "#{unquote(registry)} must be registered with a name"
#           end
#
#           defmacro __using__(name) do
#             registry = unquote(registry)
#             module = Module.concat(Module.split(__CALLER__.module) ++ [Registry, For] ++ Module.split(__MODULE__))
#             quote location: :keep do
#               unless Code.ensure_compiled? unquote(module) do
#                 defmodule unquote(module) do
#
#                   defmacro __before_compile__(env) do
#                     registry = unquote(registry)
#                     quote location: :keep do
#                       def unquote(registry)() do
#                         unquote(Macro.expand_once({:@, env, [{registry, [], __MODULE__}]}, env))
#                       end
#                     end
#                   end
#
#                 end
#
#                 @before_compile unquote(module)
#                 Module.register_attribute(__MODULE__, unquote(registry), accumulate: true)
#               end
#               Module.put_attribute(__MODULE__, unquote(registry), {unquote(name), unquote(__MODULE__)})
#             end
#           end
#
#         end
#       end
#
#       defoverridable [__using__: 1]
#
#     end
#   end
#
# end
