class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, presence: true
  validates(
    :sex,
    inclusion: { in: ["M", "F"] , message: "You must choose a valid cat sex"})
  validates(
   :color,
   inclusion: { in: %w{ red orange yellow blue indigo violet black white other},
   message: "You must choose a color"})

   has_many :cat_rental_requests, dependent: :destroy

end
