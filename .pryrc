# frozen_string_literal: true

require_relative 'lib/wordnik'
Pry.config.prompt_name = 'Wordnik'
client = Wordnik::Client.new
puts "Welcome, #{ENV['USER']}! The word of the day is: “#{client.wotd[:word]}”."
puts "You can now use `client` to access the Wordnik API; for example client.definitions('erinaceous', limit:1)."
methods = ((client.methods - Object.methods) - %i[configuration configuration=]).sort
puts "Methods are: #{methods.join(', ')}"
