defmodule Slackkit.Registry do

  defmacro __using__([]) do
    raise ArgumentError, "must provide a registry name"
  end

  defmacro __using__(registry) do
    quote location: :keep do

      defmacro __using__(_) do
        registry = unquote(registry)
        quote location: :keep do

          defmacro __using__([]) do
            raise ArgumentError, "#{unquote(registry)} must be registered with a name"
          end

          defmacro __using__(name) do
            registry = unquote(registry)
            module = Module.concat(Module.split(__CALLER__.module) ++ [Registry, For] ++ Module.split(__MODULE__))
            quote location: :keep do
              unless Code.ensure_compiled? unquote(module) do
                defmodule unquote(module) do

                  defmacro __before_compile__(env) do
                    registry = unquote(registry)
                    quote location: :keep do
                      def unquote(registry)() do
                        unquote(Macro.expand_once({:@, env, [{registry, [], __MODULE__}]}, env))
                      end
                    end
                  end

                end

                @before_compile unquote(module)
                Module.register_attribute(__MODULE__, unquote(registry), accumulate: true)
              end
              Module.put_attribute(__MODULE__, unquote(registry), {unquote(name), unquote(__MODULE__)})
            end
          end

        end
      end

      defoverridable [__using__: 1]

    end
  end

end
