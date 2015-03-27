defmodule Usuario do
  defstruct nome: "nome default"
end

defmodule Test do
  user = %Usuario{}
  IO.puts "#{inspect user}"

  # criando o memso usuário com um mapa dinamicamente
  outro_user = %{__struct__: Usuario, nome: "Outro User"}
  IO.puts "#{inspect outro_user}" # qual será o resultado?
end