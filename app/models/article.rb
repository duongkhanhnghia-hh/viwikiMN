class Article < ApplicationRecord
  belongs_to :category
  resourcify

  has_paper_trail

end
