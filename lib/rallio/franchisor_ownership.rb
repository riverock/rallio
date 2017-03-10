module Rallio
  class FranchisorOwnership < Base
    attribute :user_id, Integer
    attribute :franchisor_id, Integer
    attribute :franchisor_name, String
  end
end
