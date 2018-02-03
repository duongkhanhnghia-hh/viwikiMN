class Category < ApplicationRecord
  acts_as_nested_set
  resourcify

  include NestedTree  

  has_many :articles
  has_many :comments,  :dependent => :destroy
  has_one :post,  :dependent => :destroy  
  has_paper_trail
end
