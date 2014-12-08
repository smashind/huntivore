class PropertiesController < ApplicationController
	before_action :set_property, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit, :destroy]

	def index
		@properties = Property.all
	end

	def show
	end

	def new
		@property = Property.new
	end

	def create
		@property = current_user.properties.new(property_params)
		if @property.save
			redirect_to @property, notice: "Property was successfully added."
		else
			render action: 'new'
		end
	end

	def edit
		unless current_user == @property.user 
			redirect_to root_path, notice: "You don't have permission to do that."
		end
	end

	def update
		if @property.update_attributes(property_params)
			redirect_to @property, notice: "Property was successfully updated."
		else
			render action: 'edit'
		end
	end

	def destroy
		@property.destroy
		redirect_to properties_path, notice: "Property was successfully deleted."
	end

	private

	  def set_property
	  	@property = Property.find(params[:id])
	  end

	  def property_params
	  	params.require(:property).permit(:title, :description, :hunttype, :location, :accommodates, :price)
	  end
end