defmodule KV.Bucket do
  @doc """
  Starts a new bucket.
  """
  def start_link do
    Agent.start_link(fn -> HashDict.new end)  
  end

  @doc """
  Gets a value frim the `bucket` by `key`.
  """  
  def get(bucket, key) do
	  Agent.get(bucket, &HashDict.get(&1, key))
  end
  @doc """
  Puts the `value` for given `key` in the `bucket`.
  """
  def put(bucket, key, value) do
	Agent.update(bucket, &HashDict.put(&1, key, value))
  end
  
  @doc """
  Delete `key` from `bucket`.
  
  Returns the current value of `key`, if `key` exists.
  """
  def delete(bucket, key) do
	  Agent.get_and_update(bucket, &HashDict.pop(&1, key))
  end
end