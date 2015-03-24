defmodule DesafioCsTest do
  use ExUnit.Case

  test "the truth" do
    assert 1 + 1 == 2
  end

	test "com string" do
		assert "minha string bonita" =~ "string"
	end

	test "que irá quebrar tudo" do
    assert "minha string bonita" =~ "sua feia"
  end

	test "que podemos chamar uma url" do
		{:ok, response} = HTTPoison.get "https://api.bitbucket.org/2.0/repositories/suporte_concrete/desafio-android/pullrequests"
		assert is_map(response.headers)
		assert response.status_code == 200
		assert is_binary(response.body)
	end

	test "que conseguimos parsear um JSON" do
		result = Poison.decode! "{\"json_key\": \"json_value\"}"
		assert is_map(result)
		assert result["json_key"] == "json_value"
	end

	test "que retornamos um mapa simplificado de pull requests" do

		result = DesafioCs.pullrequests usuario: "suporte_concrete", repositorio: "desafio-android"

		assert is_list(result)
		Enum.each result, &(is_map(&1))
	end

end
