# module Authenticatable
#   extend ActiveSupport::Concern
#
#   included do
#     has_secure_password
#   end
#
#   module ClassMethods
#     def authenticate(attributes={})
#       email    = attributes[:email].present? && attributes[:email].downcase
#       password = attributes[:password]
#
#       user = find_or_initialize_by(email: email)
#
#       if user.persisted? && user.authenticate(password)
#         if user.confirmed?
#           user.authenticated
#         else
#           user.errors.add(:authentication_token, I18n.t('sessions.not_activated'))
#         end
#       else
#         user.errors.add(:authentication_token, I18n.t('sessions.invalid'))
#       end
#
#       user
#     end
#   end
#
#   def authenticated
#     generate_authentication_token
#     update_sign_in_information
#     save
#   end
#
#   protected
#
#   def generate_authentication_token
#     self.authentication_token = GenerateToken.new.call
#   end
#
#   def update_sign_in_information
#     self.last_sign_in_at = self.current_sign_in_at
#     self.current_sign_in_at = Time.now.utc
#     self.sign_in_count += 1
#   end
# end
