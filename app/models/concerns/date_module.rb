module DateModule
  extend ActiveSupport::Concern

  private
    def format_date_usa(value)
      return value if value.is_a?(Time)

      value = value.split('/')
      Date.new(value[2].to_i, value[1].to_i, value[0].to_i) rescue ''
    end
end
