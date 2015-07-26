class ContactsController < ApplicationController

  def create
    contact = Contact.new(contact_params)
    p contact
    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    contact = Contact.find(params[:id])
    render json: contact
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    render text: "#{contact.name}"
  end

  def index
    puts "made it to index"
    user = User.find(params[:user_id])
    contacts = user.contacts + user.shared_contacts
    render json: contacts
  end

  private

  def contact_params
    params.require(:contact).permit([:name, :email, :user_id])
  end


end
