class Dashboard
  alias :read_attribute_for_serialization :send
  attr_accessor :weights

  def initialize(current_user)
    @current_user = current_user
  end

  def weights
    @weights ||= @current_user.peso_ordered
  end

  def self.model_name
    @_model_name ||= ActiveModel::Name.new(self)
  end
end