# Be sure to restart your server when you modify this file.

# com esse estava dando erro: (JSON::ParserError (795: unexpected token at)
# Rails.application.config.action_dispatch.cookies_serializer = :json

Rails.application.config.action_dispatch.cookies_serializer = :hybrid
