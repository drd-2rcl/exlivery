Exlivery.start_agents()

alias Exlivery.Users.User
alias Exlivery.Orders.Item
alias Exlivery.Orders.Order

# -> Criando um user
{:ok, user} = User.build("Rua Santo Domingues", "Diogo", "diogo@gmail.com", "12345678910", 28)

# -> Criando um item
{:ok, item} = Item.build("Açaí", :sobremesa, "15.0", 1)

# -> Criando uma ordem
{:ok, order} = Order.build(user, [item])


# -> Iniciando o OrderAgent
alias Exlivery.Orders.Agent, as OrderAgent
OrderAgent.start_link(%{})

# -> Salvando uma ordem no estado
OrderAgent.save(order)

-------------- // --------------

# -> Criando user pela facade create_or_update_user

users_params = %{name: "Diogo", email: "diogo@email.com", address: "Rua Santo Domingues", cpf: "12345678910", age: 28}

Exlivery.create_or_update_user(users_params)

# -> Criando order pela facade create_or_update_order

items = [
  %{description: "Pizza de brocolis", category: :pizza, unity_price: 35.50, quantity: 1},
  %{description: "Açaí", category: :sobremesa, unity_price: 15.0, quantity: 1}
]

Exlivery.create_or_update_order(%{user_cpf: "12345678910", items: items})
