class Ingredient < ApplicationRecord
  belongs_to :Step, optional: true
  attr_accessor :unit_processed

end
