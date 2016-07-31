defmodule Slackkit.Message.Sigils do

  defmacro sigil_m({:<<>>, _meta, [string]}, _modifiers) when is_binary(string) do
    string |> Macro.unescape_string |> sanitize_raw
  end
  defmacro sigil_m({:<<>>, meta, pieces}, modifiers) do
    {:<<>>, meta, sanitize_raw(pieces)}
  end

  defmacro sigil_M({:<<>>, meta, [string]}, _modifiers) do
    sanitize_raw string
  end

  # List entry point
  defp sanitize_raw(list) when is_list(list) do
    sanitize_raw list, []
  end
  # Recursion complete
  defp sanitize_raw([], acc) do
    :lists.reverse acc
  end
  # Recurse
  defp sanitize_raw([string | pieces], acc) when is_binary(string) do
    sanitize_raw pieces, [sanitize_raw(string) | acc]
  end
  defp sanitize_raw([code | pieces], acc) do
    sanitize_raw pieces, [code | acc]
  end
  # Single case
  defp sanitize_raw(string) when is_binary(string), do: string
   |> String.replace("&", "&amp;")
   |> String.replace("<", "&lt;")
   |> String.replace(">", "&gt;")

end
