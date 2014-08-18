class VersionsController < ApplicationController
  def revert
    @version = PaperTrail::Version.find(params[:id])
    if @version.reify
      @version.reify.save!
    else
      @version.item.destroy
    end
    
    if params[:redo] == 'true'
      link_name = view_context.icon('undo', t('links.desfazer'))
      params[:redo] = 'false'
    else
      link_name = view_context.icon('repeat', t('links.refazer'))
      params[:redo] = 'true'
    end
    
    link = view_context.link_to(link_name, revert_version_path(@version.next, redo: params[:redo]), method: :post)
    
    redirect_to :back, notice: "#{ t('mensagens.flash.paper_trail.operacao_desfeita', \
      operacao: translate_version(@version.event)) } #{ link }"
  end
end
