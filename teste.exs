defmodule Usuario do
  defstruct nome: "nome default"
end

defmodule Test do
	user = %Usuario{}
	IO.puts "#{user.nome}"
end

