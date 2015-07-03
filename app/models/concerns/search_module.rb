module SearchModule
  extend ActiveSupport::Concern

  included do
    scope :listar, -> (search = nil, order = 'nome') {
      select(:id, :nome)
        .search(search)
        .order(order)
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
