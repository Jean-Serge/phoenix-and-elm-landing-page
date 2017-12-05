defmodule LandingPage.Marketing do
  @moduledoc """
  The Marketing context.
  """

  alias LandingPage.Repo

  alias LandingPage.Marketing.Lead

  @google_recaptcha_client Application.get_env(:landing_page, :google_recaptcha_client)

  @doc """
  Verifies the recaptcha token using `@google_recaptcha_client` and
  creates the lead if the verification succeeds.
  """
  def subscribe(lead_params) do
    token = Map.get(lead_params, "recaptcha_token")

    with {:ok, %{success: true}} <- @google_recaptcha_client.verify_site(token),
         {:ok, lead} <- create_lead(lead_params) do
      {:ok, lead}
    else
      {:ok, %{success: false}} ->
        {:error, :invalid_recaptcha_token}

      {:error, response} ->
        {:error, response}
    end
  end

  @doc """
  Creates a lead.

  ## Examples

      iex> create_lead(%{field: value})
      {:ok, %Lead{}}

      iex> create_lead(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lead(attrs \\ %{}) do
    %Lead{}
    |> Lead.changeset(attrs)
    |> Repo.insert()
  end
end
