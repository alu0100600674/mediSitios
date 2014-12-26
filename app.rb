# -*- coding: utf-8 -*-
require 'sinatra'
require 'data_mapper'


DataMapper.setup( :default, ENV['DATABASE_URL'] ||
"sqlite3://#{Dir.pwd}/db/lugares.db" ) if development?
DataMapper.setup( :default, ENV['DATABASE_URL'] ) if production?
DataMapper::Logger.new($stdout, :debug)
DataMapper::Model.raise_on_save_failure = true

require_relative 'model'

DataMapper.finalize

#DataMapper.auto_migrate!
DataMapper.auto_upgrade!

Base = 36


get '/' do
  erb :index
end

get'/recomendados' do
  erb :recomendados
end

get'/buscar-sitio' do
  erb :bsitio
end

get '/buscar-enfermedad' do
  erb :benfermedad
end

get '/buscar-beneficio' do
  erb :bbeneficio
end
