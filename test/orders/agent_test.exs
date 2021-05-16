defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Order
  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "save/1" do
    test "saves the order" do
      order = build(:order)

      OrderAgent.start_link(%{})

      assert {:ok, _uuid} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(%{})

      :ok
    end

    test "when the order is found, returns the order" do
      {:ok, uuid} =
        :order
        |> build()
        |> OrderAgent.save()

      response = OrderAgent.get(uuid)

      expected_response =
        {:ok,
          %Order{
            delivery_address: "Rua Santo Domingues",
            items:
              [
                %Item{
                  category: :pizza,
                  description: "Pizza de peperoni", quantity: 1,
                  unity_price: Decimal.new("35.5")
                },
                %Item{
                  category: :japonesa,
                  description: "Temaki de atum",
                  quantity: 2,
                  unity_price: Decimal.new("20.50")
                }
              ],
              total_price: Decimal.new("76.50"),
              user_cpf: "12345678910"
            }
          }

          assert response == expected_response
    end

    # test "when the user is not found, returns the error" do
    #   response = UserAgent.get("00000000000")

    #   expected_response = {:error, "User not found"}

    #   assert response == expected_response
    # end
  end
end
