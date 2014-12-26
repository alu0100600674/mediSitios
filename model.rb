class Lugares
  include DataMapper::Resource

  property :id, Serial
  property :nombre, Text

  has n, :beneficios
end

class Beneficio
  include DataMapper::Resource

  property :id, Serial
  property :n_ben, Text

  belongs to, :lugares
  belongs to, :enfermedad
end

class Enfermedad
  include DataMapper::Resource

  property :id, Serial
  property :n_enf, Text

  has n, :beneficios
end
