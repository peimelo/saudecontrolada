#encoding:utf-8
RSpec.describe MailNotifier do
  describe '.contato' do
    let(:contato) { FactoryGirl.create(:contato) }
    let(:mail) { MailNotifier.contato(contato) }

    it 'Enviar para o suporte os dados do contato' do
      expect(mail.subject).to eq I18n.t('mail_notifier.contato.subject')
      expect(mail.to).to eq [Rails.application.secrets.mailer_from]
      expect(mail.from).to eq [Rails.application.secrets.mailer_sender]
      expect(mail.body.encoded).to match contato.mensagem
    end
  end

  describe '.novo_user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { MailNotifier.novo_user(user) }

    it 'Enviar para o suporte os dados do novo user' do
      expect(mail.subject).to eq I18n.t('mail_notifier.novo_user.subject', email: user.email)
      expect(mail.to).to eq [Rails.application.secrets.mailer_from]
      expect(mail.from).to eq [Rails.application.secrets.mailer_sender]
      expect(mail.body.encoded).to match user.email
    end
  end
end
