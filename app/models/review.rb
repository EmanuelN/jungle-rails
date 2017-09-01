class UserProductValidator < ActiveModel::Validator
  def validate(record)
    if Product.exists?(id: record.product_id)
    else
      record.errors[:product] << "This product doesn't exist"
    end
    if User.exists?(id: record.user_id)
    else
      record.errors[:user] << "This user ID is invalid"
    end
  end
end

class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :product_id, presence: true
  validates :user_id, presence: true

  validates_with UserProductValidator

end

