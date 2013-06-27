require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'

get '/' do
	puts "We're at /!"
end

# by analogy
# '/1/addition/2'
# get '/:first/:operation/:second'
# param[:first].to_f
get '/newmovie/:title' do
# The user has posted data from the form. 
# imdb api to go search for the title. 
# @title is a string
@title = params[:title]

# A movie with the title "@title"
@movie = 
	Imdb::Search.new("#{@title}").movies.first
# Don't forget that you can debut this way. 
# puts "Movie details: " @movie.inspect
#binding.pry{}

title = @movie.title
plot_summary = @movie.plot_summary

# What is the type of this variable?
# File object, points to movies.csv
output_file = File.new('movies.csv', 'a+')
output_file.puts("#{title}|#{plot_summary}")
output_file.close

redirect to '/'

# Take all that info, and put into the csv file. 
end
