class Category < ApplicationRecord
  acts_as_nested_set
  resourcify

  include NestedTree  

  has_many :articles
  has_many :comments
  has_one :post  
  has_paper_trail
end
