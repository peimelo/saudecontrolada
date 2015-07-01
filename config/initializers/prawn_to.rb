# http://prawnpdf.org/docs/0.11.1/Prawn/Document.html
module MyHelperModule

  def tabela_linhas
    table linhas do
      row(0).font_style = :bold
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end

end

Prawn::Document.extensions << MyHelperModule
