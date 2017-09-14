class Category < ApplicationRecord
  acts_as_nested_set
  resourcify

  include NestedTree

  has_many :articles
  has_many :posts

end
