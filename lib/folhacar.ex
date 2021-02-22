# Folhacar.get_cars("tucson")

defmodule Folhacar do
  @car_attributes ["Título", "Ano/Preço", "Combustivel", "Cor", "KM"]

  def get_cars, do: "Cars"
  def get_cars(name) do
    IO.puts "Carro por nome."

    case HTTPoison.get("https://folhacar.com.br/resultados/tipo/carros/busca/#{name}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        parse_content(body)
    end
  end

  defp parse_content(body) do
    cars = body
    |> Floki.find(".tab-content")
    |> Enum.map(fn car ->
      car_attributes = car_info(car)
      [
        car_title(car),
        car_year(car),
        Enum.at(car_attributes, 0),
        Enum.at(car_attributes, 1),
        Enum.at(car_attributes, 2)
      ]
    end)

    print_table(cars)
  end

  defp car_info(car) do
    car
    |> Floki.find(".listings-grid__attrs li")
    |> Enum.map(fn attr ->
      Floki.text(attr)
      |> String.trim
    end)
  end

  defp car_title(car) do
    car
    |> Floki.find(".listings-grid__body h5")
    |> Floki.text
    |> String.trim
  end

  defp car_year(car) do
    car
    |> Floki.find(".listings-grid__price")
    |> Floki.text
    |> String.trim
  end

  defp print_table(rows) when is_list(rows) do
    rows
    |> TableRex.quick_render!(@car_attributes, "Resultados")
    |> IO.puts
  end
  defp print_table(_), do: IO.puts("Not a list")
end
