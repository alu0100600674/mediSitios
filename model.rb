class Lugares
  include DataMapper::Resource

  property :id, Serial
  property :nombre, Text

  has n, :beneficios
  has n, :enfermedad
end

class Beneficio
  include DataMapper::Resource

  property :id, Serial
  property :n_ben, Text

  belongs_to :lugares
end

class Enfermedad
  include DataMapper::Resource

  property :id, Serial
  property :n_enf, Text

  belongs_to :lugares
end
