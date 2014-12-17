class PropertyAttachmentsController < ApplicationController
  def destroy
  	@property_attachment = PropertyAttachment.find(params[:id])
  	@property_attachment.destroy
  	redirect_to(:back)
  end
end
