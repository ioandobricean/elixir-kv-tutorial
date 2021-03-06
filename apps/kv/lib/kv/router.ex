defmodule KV.Router do
  @doc """
  Dispatch the given `mod`, `fun`, `args` requests
  to the appropriate node based on the `bucket.`
  """
  def route(bucket, mod, fun, args) do
    # Get the first byte of the binary
    first = :binary.first(bucket)

    # Try to find an entry in the table or raise
    entry =
      Enum.find(table, fn {enum, node} ->
        first in enum
      end) || no_entry_error(bucket)

    # If the entry node is the current node
    if elem(entry, 1) == node() do
      apply(mod, fun, args)
    else
      sup = {KV.RouterTask, elem(entry, 1)}
      Task.SUpervisor.async(sup, fn ->
        KV.Router.route(bucket, mod, fun, args)
      end) |> Task.await()
    end
  end

  defp no_entry_error(bucket) do
    raise "could not find entry for #{inspect bucket} in table #{inspect table}"
  end

  def table do
    Application.get_env(:kv, :routing_table)
  end
end