class Location < ApplicationRecord
  belongs_to :user

  before_save :geocode

  validates_presence_of :city, :country

  geocoded_by :address

  def address
    address_fields = [street, city, area, country]
    address_fields.reject!(&:blank?)
    address_fields.compact.join(', ')
  end
end
