class MailNotifier < ActionMailer::Base
  default from: Rails.application.secrets.mailer_sender
  default reply_to: Rails.application.secrets.mailer_from

  # methods ---------------------------------------------------------------------------------------
  def contato(contato)
    @contato  = contato

    mail(
      subject: I18n.t('mail_notifier.contato.subject'),
      to: Rails.application.secrets.mailer_from
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

  def novo_user(user)
    @user = user

    mail(
      subject: I18n.t('mail_notifier.novo_user.subject', email: @user.email),
      to: Rails.application.secrets.mailer_from
    )
  end
end
