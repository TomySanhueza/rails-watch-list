# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'uri'
require 'net/http'
require 'json'
url = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=3")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZDU5NmY1ZDIyOTg4MjU3OTIyNmMzYzAzZTNlMjZkNiIsIm5iZiI6MTc0ODEwMDQ3NS45NTM5OTk4LCJzdWIiOiI2ODMxZTU3YjZkNzA3OGM4NjE0MTM5N2UiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.iRuH55Wvv30SIoozib-XT2F43cWMXo5xD6LcelV02t8'

response = JSON.parse(http.request(request).read_body)
results = response['results']

results.each do |movie|
  Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
    rating: movie['vote_average']
  )
end

# lists = [
#   { name: "Cine Oscuro: Noches de Suspenso" },
#   { name: "Viajes en el Tiempo y Realidades Alternas" },
#   { name: "Amistades Inesperadas" },
#   { name: "Viajes Épicos y Aventuras Legendarias" },
#   { name: "Romances que Trascienden la Era" },
#   { name: "Comicidades Locas y Risas Ajenas" },
#   { name: "Fantasía y Magia Moderna" },
#   { name: "Desastres y Catástrofes Cinematográficas" },
#   { name: "Thrillers Psicológicos: La Mente en Juego" },
#   { name: "Clásicos Imperecederos del Cine" }
# ]
# lists.each do |list_attrs|
#   List.find_or_create_by!(name: list_attrs[:name])
# end
