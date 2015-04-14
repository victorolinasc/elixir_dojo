
defmodule OlaMundo do

  def start lista_inicial do
    spawn __MODULE__, :loop, [lista_inicial]
  end

  def loop lista_de_pessoas do
    receive do
      {from, :lista_de_pessoas} ->
        send from, {self, lista_de_pessoas}
        # até aqui tudo bem... nada de novo
        # mas como guardamos as pessoas para as quais demos olá?
        # recursão :D
        loop lista_de_pessoas    
      :terminar ->
        IO.puts "Terminando processo. Pessoas na lista: #{inspect lista_de_pessoas}"
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
      {^pid, mensagem} -> IO.puts mensagem
    after 
      1500 -> IO.puts "Sem olá para você" # um truque novo! Podemos ter timeouts para não travar o shell.
    end
  end

  def pessoas pid do
    send pid, {self, :lista_de_pessoas}    
    receive do
      {^pid, lista} -> Enum.each lista, &(IO.puts "Pessoa: #{&1}") # sintaxe nova !!!
    after 
     1500 -> IO.puts "Sem pessoas para você"
    end
  end

  def terminar pid do
    send pid, :terminar # acabou o loop!
  end
end

pid = OlaMundo.start []

OlaMundo.ola pid, "Fulano"
OlaMundo.ola pid, "Beltrano"
OlaMundo.ola pid, "Ciclano"

OlaMundo.pessoas pid
OlaMundo.terminar pid

OlaMundo.ola pid, "Fulano" # timeout!