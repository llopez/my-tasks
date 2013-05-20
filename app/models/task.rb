class Task < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  validates :title, presence: true, length: {minimum: 3, maximum: 20}
end
