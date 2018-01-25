class Post < ApplicationRecord

  has_paper_trail

  belongs_to :user
  has_many :comments
  belongs_to :category
end
