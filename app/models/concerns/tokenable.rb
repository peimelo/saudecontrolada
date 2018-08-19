# module Tokenable
#   extend ActiveSupport::Concern
#
#   module ClassMethods
#     def friendly_token(field_name, n=64)
#       loop do
#         random_token = SecureRandom.urlsafe_base64(n)
#         break random_token unless exists?(field_name => random_token)
#       end
#     end
#   end
# end
