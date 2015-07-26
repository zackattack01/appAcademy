class ContactSharesController < ApplicationController
  def create
    contact_share = ContactShare.new(contact_share_params)
    if contact_share.save
      render json: contact
    else
      render(
        json: contact_shares.errors.full_messages, status: :unprocessable_entity
      )
  end

  def destroy
    contact_share = ContactShare.find(params[:id])
    contact_share.destroy
    render text: "#{contact_share.user_id} to #{contact_share.contact_id} is destroyed"
  end

  private

    def contact_share_params
      params.require(:contact_share).permit([:user_id, :contact_id])
    end
end
