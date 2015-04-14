defmodule OlaMundoDistribuido do

  def start lista_inicial do
    pid = spawn __MODULE__, :loop, [lista_inicial]
		Process.register pid, :ola_mundo
  end

  def loop lista_de_pessoas do
    receive do
      :terminar ->
        IO.puts "Tentando terminar o processo."
				loop lista_de_pessoas

      {from, :lista_de_pessoas} ->
        send from, {self, lista_de_pessoas}
        loop lista_de_pessoas    

      {from, pessoa} ->
        send from, {self, "Olá #{pessoa}"}
        loop [ pessoa | lista_de_pessoas ]

      _ ->
        IO.puts "Ignorando mensagem"
        loop lista_de_pessoas
    end
  end

  def ola(pid, pessoa) when is_binary(pessoa) do
    send pid, {self, pessoa}    
    receive do
      # estamos usando esse chapeuzinho antes da variável... por quê? Veja o bloco de atenção abaixo :D
      {^pid, mensagem} -> IO.puts mensagem
    after 
      15000 -> IO.puts "Sem olá para você" # um truque novo! Podemos ter timeouts para não travar o shell.
    end
  end

  def pessoas pid do
    send pid, {self, :lista_de_pessoas}    
    receive do
      {^pid, lista} -> Enum.each lista, &(IO.puts "Pessoa: #{&1}") # sintaxe nova !!!
    after 
     15000 -> IO.puts "Sem pessoas para você"
    end
  end

  def terminar pid do
    send pid, :terminar # acabou o loop!
  end
end
