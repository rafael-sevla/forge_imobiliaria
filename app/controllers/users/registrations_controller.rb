class Users::RegistrationsController < Devise::RegistrationsController
  layout :registrations_layout

  private

  def registrations_layout
    action_name == "edit" ? "admin" : "auth"
  end
end
