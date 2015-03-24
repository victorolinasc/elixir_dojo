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
end
