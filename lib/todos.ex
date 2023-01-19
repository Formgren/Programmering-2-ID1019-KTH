defmodule Todos do
  def hello_world do
    "HelloWorld"
  end
  def listUsers do
    users = [
      john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
      mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
    ]
    users = put_in users[:john].age, 31

end

T2
end
