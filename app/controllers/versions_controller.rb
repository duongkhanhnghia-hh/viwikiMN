class VersionsController < ApplicationController
	def index
		@versions = PaperTrail::Version.all
	end 
end
