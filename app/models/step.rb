class Step < ApplicationRecord
  belongs_to :recipe, optional: true 
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, reject_if: :reject_ingredients, allow_destroy: true

  def reject_ingredients(attributes)
    attributes['name'].blank? || attributes['amount'].blank? || attributes['unit'].blank?
  end
end
