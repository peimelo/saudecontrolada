class Privileges
  # constructor -----------------------------------------------------------------------------------
  def initialize
    @items = []
  end

  # atributos -------------------------------------------------------------------------------------
  attr_reader :items

  # methods ---------------------------------------------------------------------------------------
  def add(acao, controlador)
    @items << "#{controlador}/#{acao}" if !item_existe?(acao, controlador)
  end
  
  def item_existe?(acao, controlador)
    self.items.each do |item|
      return true if item == "#{controlador}/#{acao}"
    end
    
    return false
  end
end