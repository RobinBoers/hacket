defmodule Hacket do
  @moduledoc """
  Core helpers for hacket.
  """

  alias Calendar.DateTime.{Format, Parse}

  @doc """
  Convert markdown into safe HTML
  """
  def markdown(text) do
    text
    |> IO.inspect()
    |> String.trim()
    |> Earmark.as_html!()
    |> HtmlSanitizeEx.basic_html()
    |> Phoenix.HTML.raw()
  end

  @doc """
  Get current NaiveDateTime without seconds
  """
  def datetime() do
    DateTime.utc_now()
    |> DateTime.to_naive()
    |> NaiveDateTime.truncate(:second)
  end

  @doc """
  Convert NaiveDateTime into the RFC822 format used by RSS
  """
  def to_rfc822(datetime) do
    datetime
    |> NaiveDateTime.to_erl()
    |> Calendar.DateTime.from_erl!("Etc/UTC")
    |> Format.rfc2822()
  end

  @doc """
  Convert RFC822 DateTime format into NaiveDateTime
  """
  def from_rfc822(datetime) do
    {:ok, datetime} =
      datetime
      |> Parse.rfc2822_utc()

    DateTime.to_naive(datetime)
  end

  @doc """
  Remove the :ok part of an ok- or errortuple.
  """
  def strip_ok({:ok, data}), do: data
  def strip_ok({:ok, data, _}), do: data
end
