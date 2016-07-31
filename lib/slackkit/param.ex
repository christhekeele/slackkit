defprotocol Slackkit.Param do
  @fallback_to_any true

  @spec to_param(term) :: String.t
  def to_param(term)
end

defimpl Slackkit.Param, for: Integer do
  def to_param(int), do: Integer.to_string(int)
end

defimpl Slackkit.Param, for: BitString do
  def to_param(bin) when is_binary(bin), do: bin
end

defimpl Slackkit.Param, for: Atom do
  def to_param(nil) do
    raise ArgumentError, "cannot convert nil to param"
  end

  def to_param(atom) do
    Atom.to_string(atom)
  end
end

defimpl Slackkit.Param, for: Map do
  def to_param(map) do
    map |> Enum.map(&(Slackkit.Param.to_param(&1))) |> Enum.into(%{})
  end
end

defimpl Slackkit.Param, for: List do
  def to_param(list) do
    list |> Enum.map(&(Slackkit.Param.to_param(&1)))
  end
end

defimpl Slackkit.Param, for: Tuple do
  def to_param({key, value}) do
    { Slackkit.Param.to_param(key), Slackkit.Param.to_param(value) }
  end

  def to_param(tuple) do
    raise ArgumentError,
      "non two-tuples cannot be converted to_param. A two-tuple was expected, got: #{inspect tuple}"
  end
end

defimpl Slackkit.Param, for: Any do
  defmacro __deriving__(module, struct, options) do
    deriving(module, struct, options)
  end

  def deriving(module, struct, options) do
    key = Keyword.get(options, :key, :id)

    unless Map.has_key?(struct, key) do
      raise ArgumentError, "cannot derive Slackkit.Param for struct #{inspect module} " <>
                           "because it does not have key #{inspect key}. Please pass " <>
                           "the :key option when deriving"
    end

    quote do
      defimpl Slackkit.Param, for: unquote(module) do
        def to_param(%{unquote(key) => nil}) do
          raise ArgumentError, "cannot convert #{inspect unquote(module)} to param, " <>
                               "key #{inspect unquote(key)} contains a nil value"
        end

        def to_param(%{unquote(key) => key}) when is_integer(key), do: Integer.to_string(key)
        def to_param(%{unquote(key) => key}) when is_binary(key), do: key
        def to_param(%{unquote(key) => key}), do: Slackkit.Param.to_param(key)
      end
    end
  end

  def to_param(%{id: nil}) do
    raise ArgumentError, "cannot convert struct to param, key :id contains a nil value"
  end
  def to_param(%{id: id}) when is_integer(id), do: Integer.to_string(id)
  def to_param(%{id: id}) when is_binary(id), do: id
  def to_param(%{id: id}), do: Slackkit.Param.to_param(id)

  def to_param(map) when is_map(map) do
    raise ArgumentError,
      "structs expect an :id key when converting to_param or a custom implementation " <>
      "of the Slackkit.Param protocol (read Slackkit.Param docs for more information), " <>
      "got: #{inspect map}"
  end

  def to_param(data) do
    raise Protocol.UndefinedError, protocol: @protocol, value: data
  end
end
