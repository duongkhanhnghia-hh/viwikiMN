class ApplicationController < ActionController::Base
 	include Pundit
  	protect_from_forgery with: :exception, prepend: true
  	before_filter :navbar
  	
  	class CatAndBook < CatAndBook
  			attr_accessor :name, :book
	end
  	def navbar
      @user = current_user
  		@allCategories = Category.all
  		@book = Array.new
  		@entries = Array.new
  		@allCategories.each do |cat|
  			if cat.children_count.to_i == 0
  				@catAndBook_tmp = CatAndBook. new
  				@catAndBook_tmp.name = cat.name
  				@cat_tmp = cat
  				while @cat_tmp.parent_id != nil
  					@cat_tmp = @allCategories.find(@cat_tmp.parent_id)
  				end
  				@catAndBook_tmp.book = @cat_tmp.name
  				if @catAndBook_tmp.book != @catAndBook_tmp.name
  					@entries.push @catAndBook_tmp
  				end
  			end
  			if cat.parent_id == nil
  				@book.push cat
  			end
  		end
  		@book.sort_by! { |m| m.name }
  		@entries.sort_by! {|m| m.name}
  	end
  
end
