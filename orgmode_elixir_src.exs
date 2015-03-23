defmodule FamosaRecursao do

  # funções públicas!
  def soma(lista) when is_list(lista), do: soma(lista, 0)

  def map(lista, funcao) when is_list(lista) and is_function(funcao) do
    map(lista, funcao, [])
  end

  # funções privadas
  # caso básico: quando a lista é vazia temos que parar a recursão
  defp soma([], acumulador), do: acumulador
  # recursão foderosa...
  defp soma [num | lista], acumulador do
    soma lista, acumulador + num
  end

  # exatament a mesma coisa...
  defp map([], _funcao, acumulador), do: acumulador
  defp map([ item | lista], funcao, acumulador) do
    map(lista, funcao, [ funcao.(item) | acumulador ])
  end

end

IO.puts "#{inspect FamosaRecursao.soma [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]}"
IO.puts "#{inspect FamosaRecursao.soma Enum.to_list(1..100)}"

IO.puts "#{inspect FamosaRecursao.map [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], fn numero -> numero + 1 end}"
IO.puts "#{inspect FamosaRecursao.map Enum.to_list(1..100), fn numero -> numero + 1 end}"
