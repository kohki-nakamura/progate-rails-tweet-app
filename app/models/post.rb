class Post < ApplicationRecord
  validates :content, presence: true, length: {maximum: 140}

  belongs_to :user
  has_many :like
end
