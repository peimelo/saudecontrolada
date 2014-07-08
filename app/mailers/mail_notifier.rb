class MailNotifier < ActionMailer::Base
  default from: Rails.application.secrets.mailer_sender
  default reply_to: Rails.application.secrets.mailer_from

  # methods ---------------------------------------------------------------------------------------
  def chamado_atualizado(chamado, pessoa_atualizadora, emails_destinatarios)
    @chamado = chamado

    @pessoa_atualizadora = pessoa_atualizadora

    mail(
      subject: I18n.t('mail_notifier.chamado_atualizado.subject', titulo: @chamado.titulo),
      to: emails_destinatarios
    )
  end

  def chamado_envolvido_adicionado(chamado, email_destinatario)
    @chamado = chamado

    mail(
      subject: I18n.t('mail_notifier.chamado_envolvido_adicionado.subject'),
      to: email_destinatario
    )
  end

  def chamado_envolvido_removido(chamado, email_destinatario)
    @chamado = chamado

    mail(
      subject: I18n.t('mail_notifier.chamado_envolvido_removido.subject'),
      to: email_destinatario
    )
  end

  def chamado_excluido(chamado, pessoa_atualizadora, emails_destinatarios, condo_id)
    @chamado = chamado

    @pessoa_atualizadora = pessoa_atualizadora

    @condo_id = condo_id

    mail(
      subject: I18n.t('mail_notifier.chamado_excluido.subject'),
      to: emails_destinatarios
    )
  end

  def chamado_novo(chamado, emails_destinatarios)
    @chamado = chamado

    mail(
      subject: I18n.t('mail_notifier.chamado_novo.subject'),
      to: emails_destinatarios
    )
  end

  def chamado_respondido(chamado, chamado_resposta, emails_destinatarios)
    @chamado = chamado
    @resposta = chamado_resposta

    mail(
      subject: I18n.t('mail_notifier.chamado_respondido.subject'),
      to: emails_destinatarios
    )
  end

  def chamado_resposta_atualizada(chamado, chamado_resposta, emails_destinatarios)
    @chamado = chamado
    @resposta = chamado_resposta

    mail(
      subject: I18n.t('mail_notifier.chamado_resposta_atualizada.subject'),
      to: emails_destinatarios
    )
  end

  def contato(contato)
    @contato  = contato

    mail(
      subject: I18n.t('mail_notifier.contato.subject'),
      to: Rails.application.secrets.mailer_from
     )
  end

  def convite(convite, condominio, convidado_por)
    @condominio = condominio
    @convidado_por = convidado_por
    @convite  = convite

    mail(
      subject: I18n.t('mail_notifier.convite.subject'),
      to: @convite.email
     )
  end

  def convite_aceito_recusado(status, condominio, usuario)
    @condominio = condominio.nome
    @usuario = "#{usuario.name} (#{usuario.email})"
    @status  = status

    if condominio.admin_id == condominio.sindico_id
      para = condominio.admin.email
    else
      para = condominio.admin.email, condominio.sindico.email
    end

    mail(
      subject: I18n.t('mail_notifier.convite_aceito_recusado.subject', status: @status, usuario: @usuario),
      to: para
     )
  end

  def convite_excluido(condominio, usuario_excluido, usuario_logado)
    @condominio = condominio.nome
    @usuario = "#{usuario_logado.name} (#{usuario_logado.email})"

    mail(
      subject: I18n.t('mail_notifier.convite_excluido.subject', condominio: @condominio),
      to: usuario_excluido.email
     )
  end

  def erro(erro)
    @erro    = erro
    @usuario = erro.user.email rescue '-'

    mail(
      subject: I18n.t('mail_notifier.erro.subject', erro: @erro.nome),
      to: Rails.application.secrets.mailer_from
    )
  end

  def novo_condo(condo)
    @condo = condo

    mail(
      subject: I18n.t('mail_notifier.novo_condo.subject', nome: @condo.nome),
      to: Rails.application.secrets.mailer_from
    )
  end

  def novo_user(user)
    @user = user

    mail(
      subject: I18n.t('mail_notifier.novo_user.subject', email: @user.email),
      to: Rails.application.secrets.mailer_from
    )
  end

  # def correspondencia( correspondencia, morador=nil )
  #   @correspondencia = correspondencia
  #
  #   if morador
  #     destinatario = "#{morador.nome} <#{morador.email}>"
  #   else
  #     destinatario = "#{correspondencia.morador.nome} <#{correspondencia.morador.email}>"
  #   end
  #
  #   mail(
  #     :subject => 'Aviso de Chegada de Correspondência',
  #     :to      => destinatario
  #    )
  # end

end