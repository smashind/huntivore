class PropertiesController < ApplicationController
	before_action :set_property, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:index, :new, :edit, :destroy]

	def index
		if params[:search]
		  @properties = Property.search(params[:search]).paginate(page: params[:page], per_page: 10)
		else
      @properties = Property.where(available: true).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end
	end

	def show
		redirect_to_good_slug(@property) and return if bad_slug?(@property)
		@reservation = Reservation.new
		@property_attachments = @property.property_attachments.all
		javascript_variables(price: @property.price, per_person: @property.per_person, hunttype: @property.hunttype, fee: HUNTIVORE_FEE)
	end

	def new
		@property = Property.new
		@property_attachment = @property.property_attachments.build
	end

	def create
		@property = current_user.properties.new(property_params)

		respond_to do |format|
			if @property.save
				if params[:property_attachments]
					params[:property_attachments]['image'].each do |a|
						@property_attachment = @property.property_attachments.create!(:image => a, :property_id => @property.id)
					end
				end
				format.html { redirect_to @property, notice: "Property was successfully added." }
				format.json { render action: 'show', status: created, location: @property }
			else
				@property.property_attachments.build
				format.html { render action: 'new' }
				format.json { render json: @property.errors, status: :unprocessable_entity }
			end
		end
	end

	def edit
		unless current_user == @property.user 
			redirect_to root_path, notice: "You don't have permission to do that."
		end
	end

	def update
		respond_to do |format|
			if @property.update_attributes(property_params)
				if params[:property_attachments]
					params[:property_attachments]['image'].each do |a|
						@property_attachment = @property.property_attachments.create!(:image => a, :property_id => @property.id)
					end
				end
				format.html { redirect_to @property, notice: "Property was successfully updated." }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @property.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@property.destroy
    redirect_to :back, alert: "Property was successfully deleted."
	end

	private

	  def set_property
	  	@property = Property.find(params[:id])
	  end

	  def property_params
	  	params.require(:property).permit(:title, :description, :hunttype, :location, :accommodates, :game_list, :price, :per_person, :available, :phone, property_attachments_attributes: [:id, :property_id, :image])
	  end
end