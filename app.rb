# -*- coding: utf-8 -*-
require 'sinatra'
require 'data_mapper'
require 'restclient'
require 'xmlsimple'


DataMapper.setup( :default, ENV['DATABASE_URL'] ||
"sqlite3://#{Dir.pwd}/lugares.db" ) if development?
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

get '/recomendados' do
  TOTAL = 24
  N_SITIOS = 4

  sitio = Array.new
  for i in 0...N_SITIOS do
    # puts "i = #{i}"
    tmp = rand(TOTAL)
    while(tmp == 0) do
      tmp = rand(TOTAL)
    end
    sitio.push(tmp)
  end

  # for i in 0...N_SITIOS do
  #   puts "* #{sitio[i]}"
  # end

  @listado = Lugares.buscarporid(sitio[0].to_i, sitio[1].to_i, sitio[2].to_i, sitio[3].to_i)
  # @listado = Lugares.buscarporid(1,2,3,4)

  # puts '----------------------------'
  # puts @listado
  # puts '----------------------------'

  erb :recomendados
end

get '/buscar-sitio' do
  erb :bsitio
end

post '/buscar-sitio' do
  lugar = params[:lugares].upcase
  @listado = Lugares.buscarsitio(lugar)

  erb :bsitio
end

get '/buscar-enfermedad' do
  erb :benfermedad
end

post '/buscar-enfermedad' do
  enfermedad = params[:enfermedades].upcase
  @listado = Lugares.buscarenfermedad(enfermedad)

  erb :benfermedad
end

get '/buscar-beneficio' do
  erb :bbeneficio
end

post '/buscar-beneficio' do
  beneficio = params[:beneficios].upcase
  @listado = Lugares.buscarbeneficio(beneficio)

  erb :bbeneficio
end

get '/datos-de-prueba' do
  Lugares.first_or_create(:nombre => "Tenerife", :provincia => "S/C de Tenerife", :pais => "España")
  Lugares.first_or_create(:nombre => "La Palma", :provincia => "S/C de Tenerife", :pais => "España")
  Lugares.first_or_create(:nombre => "La Gomera", :provincia => "S/C de Tenerife", :pais => "España")
  Lugares.first_or_create(:nombre => "El Hierro", :provincia => "S/C de Tenerife", :pais => "España")
  Lugares.first_or_create(:nombre => "Gran Canaria", :provincia => "Las Palmas de Gran Canaria", :pais => "España")
  Lugares.first_or_create(:nombre => "Lanzarote", :provincia => "Las Palmas de Gran Canaria", :pais => "España")
  Lugares.first_or_create(:nombre => "Fuerteventura", :provincia => "Las Palmas de Gran Canaria", :pais => "España")

  # Enfermedad.first_or_create(:lugares_id => 1, :n_enf => "Gripe")
  #
  # Beneficio.first_or_create(:lugares_id => 1, :n_ben => "Buen tiempo")

  redirect '/'
end

get '/datos' do
  xml = RestClient.get "https://raw.githubusercontent.com/alu0100600674/mediSitios/master/public/xml/lugares.xml"
  datos = XmlSimple.xml_in(xml.to_s)['lugar']

	datos.each do |i|
		nombre = i["nombre"].to_s.delete "[\"]"
		provincia = i["provincia"].to_s.delete "[\"]"
		pais = i["pais"].to_s.delete "[\"]"
    enf = i["enfermedades"].to_s.delete "[\"]"
    ben = i["beneficios"].to_s.delete "[\"]"
		Lugares.first_or_create(:nombre => nombre, :provincia => provincia, :pais => pais, :lista_enfermedades => enf, :lista_beneficios => ben)
	end

  redirect '/'
end

get '/borrar-datos' do
  Lugares.all.destroy
  # Enfermedad.all.destroy
  # Beneficio.all.destroy

  redirect '/'
end
