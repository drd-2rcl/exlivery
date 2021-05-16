defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, saves the user" do
      users_params = %{
        name: "Diogo",
        email: "diogo@email.com",
        address: "Rua Santo Domingues",
        cpf: "12345678910",
        age: 28
      }

      response = CreateOrUpdate.call(users_params)

      expected_response = {:ok, "User created or updated successfully"}

      assert response == expected_response
    end

    test "when all params are invalid, returns the error" do
      users_params = %{
        name: "Diogo",
        email: "diogo@email.com",
        address: "Rua Santo Domingues",
        cpf: "12345678910",
        age: 15
      }

      response = CreateOrUpdate.call(users_params)

      expected_response = {:error, "Invalid parameter"}

      assert response == expected_response
    end
  end
end
