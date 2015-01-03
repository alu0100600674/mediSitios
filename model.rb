class Lugares
  include DataMapper::Resource

  property :id, Serial
  property :nombre, Text
  property :provincia, Text
  property :pais, Text

  property :lista_enfermedades, Text
  property :lista_beneficios, Text

  # has n, :beneficios
  # has n, :enfermedad

  def self.buscarsitio(id)
    repository(:default).adapter.select("SELECT * FROM Lugares WHERE UPPER(nombre) like '%#{id}%' OR UPPER(provincia) like '%#{id}%' OR UPPER(pais) like '%#{id}%'")
  end

  def self.buscarporid(id1, id2, id3, id4)
    repository(:default).adapter.select("SELECT * FROM Lugares WHERE id == '#{id1}' OR id == '#{id2}' OR id == '#{id3}' OR id == '#{id4}'")
  end

  def self.buscarenfermedad(id)
    repository(:default).adapter.select("SELECT * FROM Lugares WHERE UPPER(lista_enfermedades) like '%#{id}%'")
  end

  def self.buscarbeneficio(id)
    repository(:default).adapter.select("SELECT * FROM Lugares WHERE UPPER(lista_beneficios) like '%#{id}%'")
  end
end

# class Beneficio
#   include DataMapper::Resource
#
#   property :id, Serial
#   property :n_ben, Text
#
#   belongs_to :lugares
#
#   def self.buscarsitio(id)
#     DataMapper.repository.adapter.select("SELECT nombre FROM Beneficios NATURAL JOIN Lugares WHERE Beneficios.id == Lugares.id AND UPPER(n_ben) like '%#{id}%'")
#   end
# end
#
# class Enfermedad
#   include DataMapper::Resource
#
#   property :id, Serial
#   property :n_enf, Text
#
#   belongs_to :lugares
#
#   def self.buscarsitio(id)
#     DataMapper.repository.adapter.select("SELECT nombre FROM Enfermedads NATURAL JOIN Lugares WHERE Enfermedads.id == Lugares.id AND UPPER(n_enf) like '%#{id}%'")
#   end
# end
