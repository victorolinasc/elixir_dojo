
defmodule ValorDefault do
  def start lista \\ [] do
    # lista não é mais um parâmetro obrigatório!
    lista
  end
end

IO.puts "#{inspect ValorDefault.start}"