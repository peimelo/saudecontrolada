class Api::V1::ContactsController < ApplicationController
  # skip_before_action :authenticate_with_token!

  def create
    contact = Contact.new(contact_params)

    if contact.save
      render status: :created, json: {
        message: I18n.t('contacts.create.message'),
        title: I18n.t('contacts.create.title')
      }
    else
      render json: contact.errors, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(
      :email,
      :name,
      :message
    )
  end
end
