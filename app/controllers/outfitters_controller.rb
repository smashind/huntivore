class OutfittersController < ApplicationController
  before_action :set_outfitter, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
    @outfitters = Outfitter.all 
  end

  def show
    redirect_to_good_slug(@outfitter) and return if bad_slug?(@outfitter)
    @outfitter_properties = @outfitter.user.properties.includes(:property_attachments).includes(:primary_image)
  end

  def new
    @outfitter = Outfitter.new
  end

  def create
    @outfitter = current_user.outfitters.new(outfitter_params)

    if @outfitter.save
      redirect_to @outfitter, notice: "Successfully added your outfitter page!"
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @outfitter.update_attributes(outfitter_params)
      redirect_to @outfitter, notice: "Successfully updated your outfitter page."
    else
      render action: 'edit'
    end
  end

  def destroy
  end

  private

    def set_outfitter 
      @outfitter = Outfitter.find(params[:id])
    end

    def outfitter_params
      params.require(:outfitter).permit(:name, :location, :description, :user_id, :profile)
    end

end
