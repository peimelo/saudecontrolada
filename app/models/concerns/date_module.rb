module DateModule
  extend ActiveSupport::Concern

  # methods defined here are going to extend the class, not the instance of it
  module ClassMethods

    def format_date_usa(value)
      return value if value.is_a?(Time)

      value = value.split('/') rescue ''
      Date.new(value[2].to_i, value[1].to_i, value[0].to_i) rescue ''
    end

  end

end
