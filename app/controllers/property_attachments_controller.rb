class PropertyAttachmentsController < ApplicationController
	
	def update 
		@property_attachment = PropertyAttachment.find(params[:id])
		@property_attachment.is_primary = true
		@property_attachment.save
		redirect_back fallback_location: :root, notice: "Successfully set as primary image."
	end

  def destroy
  	@property_attachment = PropertyAttachment.find(params[:id])
  	@property_attachment.destroy
  	redirect_to(:back)
  end

end
