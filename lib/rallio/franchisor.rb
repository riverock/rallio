module Rallio
  class Franchisor
    include Virtus.model

    attribute :id, Integer
    attribute :name, String
  end
end
