module SearchModule
  extend ActiveSupport::Concern

  private
    module ClassMethods
      def search(search)
        if search
          where('nome LIKE ?', "%#{search}%")
        else
          all
        end
      end
    end
end
