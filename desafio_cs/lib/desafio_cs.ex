defmodule DesafioCs do

  @bitbucket_url "https://api.bitbucket.org/2.0/"
	
  def pullrequests usuario: usuario, repositorio: repo do
		{:ok, %HTTPoison.Response{body: body, status_code: 200}} = HTTPoison.get @bitbucket_url <> "repositories/#{usuario}/#{repo}/pullrequests"
		%{"values" => values} = Poison.decode!(body)
		Enum.map values, fn %{"author" => %{"display_name" => author}, "created_on" => created}  -> %{ "author" => author, "created_on" => created} end
  end

  def print_pullrequests usuario: usuario, repositorio: repo do

		IO.puts "Repositório #{usuario}/#{repo}\n"

    values = pullrequests usuario: usuario, repositorio: repo
																															 
		Enum.each values, fn %{ "author" => author, "created_on" => created} ->
			IO.puts "Pull request: #{author} em #{created}"
		end
	end
	
end
