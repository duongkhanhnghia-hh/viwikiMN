class Post < ApplicationRecord
	belongs_to :category
	has_many :comments
	belongs_to :user
	has_many :votes
end
