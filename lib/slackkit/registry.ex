defmodule Slackkit.Registry do
  
  defmacro __using__([]) do
    raise ArgumentError, "must provide a registry name"
  end
  
  defmacro __using__(opts) do
    quote location: :keep do
      
      defmacro __using__(_) do
        registry = unquote(Keyword.get opts, :name)
        code = unquote(Keyword.get opts, :do, [])
        quote location: :keep do
          
          use GenEvent
          
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
                Module.register_attribute(__MODULE__, :bots, accumulate: true)
              end
              Module.put_attribute(__MODULE__, unquote(registry), {unquote(name), unquote(__MODULE__)})
            end
          end
          
          unquote code
          
        end
      end
      
    end
  end
  
  # defmacro __using__(registry) do
  #   quote location: :keep do
  # 
  #     defmacro __using__(_) do
  #       registry = unquote(registry)
  #       quote location: :keep do
  #         
  #         # IO.puts "Making #{unquote(module)}"
  #         # defmodule unquote(module) do
  #         #   defmacro __before_compile__(_env) do
  #         #     # bot_map = {:%{}, [], Macro.expand_once(quote(do: @bots), env)}
  #         #     registry = unquote(registry)
  #         #     quote location: :keep do
  #         #       def unquote(registry)() do
  #         #         IO.puts "Looking up #{unquote(registry)} from #{__MODULE__}"
  #         #         Module.get_attribute(__MODULE__, unquote(registry))
  #         #       end
  #         #     end
  #         #   end
  #         # end
  #         
  #         defmacro __using__(name) do
  #           registry = unquote(registry)
  #           quote location: :keep do
  #             registry = unquote(registry)
  #             registry_name = registry |> Atom.to_string |> String.capitalize |> String.to_atom
  #             module = Module.concat([__MODULE__, registry_name, Registry])
  #             # registry = unquote(registry)
  #             registry_body = quote location: :keep do
  #               defmacro __before_compile__(_env) do
  #                 # bot_map = {:%{}, [], Macro.expand_once(quote(do: @bots), env)}
  #                 registry = unquote(registry)
  #                 IO.puts "Compiling registry function #{unquote(registry)} from #{__MODULE__}"
  #                 quote location: :keep do
  #                   def unquote(registry)() do
  #                     IO.puts "Looking up #{unquote(registry)} from #{__MODULE__} created by #{unquote(__MODULE__)}"
  #                     Module.get_attribute(__MODULE__, unquote(registry))
  #                   end
  #                 end
  #               end
  #             end
  #             IO.puts "Creating #{module}..."
  #             Module.create module, registry_body, Macro.Env.location(__ENV__)
  #             
  #             IO.puts "#{__MODULE__} will use #{module} for #{unquote(registry)}"
  #             @before_compile module
  #             Module.register_attribute(__MODULE__, unquote(registry), accumulate: true)
  #             Module.put_attribute(__MODULE__, unquote(registry), {unquote(name), unquote(__MODULE__)})
  #             
  #           end
  #         end
  #         
  #       end
  #     end
  #     
  #   end
  # end
  
  # defmodule Builder do
  #   defmacro __before_compile__(_) do
  #     quote location: :keep do
  #       def unquote(Module.get_attribute(__CALLER__.module, :registry_name))() do
  #         unquote(Module.get_attribute(__CALLER__.module, Module.get_attribute(__CALLER__.module, :registry_name)))
  #       end
  #     end
  #   end
  # end
  # 
  # defmacro __using__(registry) do
  #   quote location: :keep do
  #     
  #     defmacro __using__(_) do
  #       registry = unquote(registry)
  #       quote location: :keep do
  #         
  #         defmacro __using__(name) do
  #           registry = unquote(registry)
  #           quote location: :keep do
  #             
  #             @before_compile Builder
  #             @registry_name unquote(registry)
  #             Module.register_attribute(__MODULE__, unquote(@registry_name), accumulate: true)
  #             Module.put_attribute(__MODULE__, unquote(@registry_name), {unquote(name), unquote(__MODULE__)})
  #             
  #           end
  #         end
  #         
  #       end
  #     end
  #     
  #   end
  # end
  
end