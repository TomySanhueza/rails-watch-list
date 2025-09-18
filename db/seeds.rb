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

url = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZDAyNGVhYjVkNzAzZDcyOGIxMmVkZDg4ZTE1NjhkNyIsIm5iZiI6MTc1ODIyMzc5Ni41OTUsInN1YiI6IjY4Y2M1ZGI0MDI1YWYxZDVhODM4MmFjZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FR-P84JSMKvA-JjCJm2Sc6bMxP7ZNHkOTgECbbDo_ig'
response = JSON.parse(http.request(request).read_body)
results = response["results"]
movie =  results.last

puts movie["title"]
puts movie["overview"]
puts "https://image.tmdb.org/t/p/original#{movie["poster_path"]}"
puts movie["vote_average"]
