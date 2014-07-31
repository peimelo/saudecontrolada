module SearchModule
  extend ActiveSupport::Concern

  included do
    # scopes --------------------------------------------------------------------------------------
    scope :listar, ->(search=nil, format=nil, page=nil, order='nome') {
      search(search)
      .order(order)
      .page(page) if format.nil?
    }
  end

  private
    module ClassMethods
      def search(search)
        if search
          where('nome LIKE ?', "%#{ search }%")
        else
          all
        end
      end
    end
end
