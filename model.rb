class Lugares
  include DataMapper::Resource

  property :id, Serial
  property :nombre, Text
  property :provincia, Text
  property :pais, Text

  has n, :beneficios
  has n, :enfermedad

  def self.buscarsitio(id)
    repository(:default).adapter.select("SELECT * FROM Lugares WHERE UPPER(nombre) like '%#{id}%' OR UPPER(provincia) like '%#{id}%' OR UPPER(pais) like '%#{id}%'")
  end
end

class Beneficio
  include DataMapper::Resource

  property :id, Serial
  property :n_ben, Text

  belongs_to :lugares

  # def self.buscarbeneficio(id)
  #   DataMapper.repository.adapter.select("SELECT nombre FROM Beneficio WHERE UPPER(n_ben) like '%#{id}%'"
  # end
end

class Enfermedad
  include DataMapper::Resource

  property :id, Serial
  property :n_enf, Text

  belongs_to :lugares

  # def self.buscarenfermedad(id)
  #   DataMapper.repository.adapter.select("SELECT nombre FROM Enfermedad WHERE UPPER(n_enf) like '%#{id}%'"
  # end
end
