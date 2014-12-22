# -*- coding: utf-8 -*-
require 'sinatra'


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
