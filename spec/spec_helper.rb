require 'rubygems'
require 'bundler/setup'
require 'grape_doc'

begin
  require 'grape'
rescue Gem::LoadError
  puts "Cannot load 'grape' gem"
end

RSpec.configure do |config|
  config.formatter = 'documentation'
end
