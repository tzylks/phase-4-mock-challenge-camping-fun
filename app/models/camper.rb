class Camper < ApplicationRecord
    has_many :signups, dependent: :destroy
    has_many :activies, through: :signups
    validates :name, presence: true
    validate :age_validation

    def age_validation
        errors.add(:age, "Whatever") if age < 8 || age > 18
    end

end
