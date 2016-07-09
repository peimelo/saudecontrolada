module Scopes
  extend ActiveSupport::Concern

  included do
    # TODO: postgress ordena primeiro maiusculas e depois minusculas
    scope :ordered, lambda {
      select(:id, :name)
        .order(:name)
    }
  end
end
