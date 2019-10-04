defmodule Lab42.Html.Message do

  defstruct severity: :error, message: "", location: 0

  @moduledoc false

  def add_message(messages, message, opts \\ []) do
    location = Keyword.get(opts, :location, 0)
    severity = Keyword.get(opts, :severity, :error)
    [%__MODULE__{severity: severity, location: location, message: message}|messages]
  end

  @error_severities ~w(critical error fatal)a
  def result(data, messages) do
    status =
      if Enum.any?(messages, &Enum.member?(@error_severities, &1.severity == :error)), do: :error, else: :ok
    { status, data, messages }
  end

  def extract!(result)
  def extract!({:ok, result, _}), do: result

end
