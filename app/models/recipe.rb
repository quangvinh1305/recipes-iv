class Recipe < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  has_many :steps, dependent: :destroy
  has_many :ingredients, through: :steps
  attr_accessor :conver_to_unit
  attr_accessor :cooking_mode
  attr_accessor :current_cooking_step

  accepts_nested_attributes_for :steps, reject_if: :reject_steps, allow_destroy: true
  
  def reject_steps(attributes)
    attributes['description'].blank?
  end

  def ingredients_converted
    ingredients.each do |ingredient|
      if conver_to_unit.present?
        begin 
          unit = Unit.new("#{ingredient.amount} #{ingredient.unit}")
          ingredient.unit_processed = unit.convert_to(conver_to_unit)
        rescue
          ingredient.unit_processed = "cant convert_to #{conver_to_unit}"
        end
      else
        ingredient.unit_processed = "#{ingredient.amount} #{ingredient.unit}"
      end
    end

    ingredients
  end
end
