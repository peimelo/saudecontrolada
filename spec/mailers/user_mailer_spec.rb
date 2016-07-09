RSpec.describe UserMailer do
  describe 'confirmation' do
    let(:user) { create(:user)}
    let(:mail) { UserMailer.confirmation(user, user.email) }

    it 'renders the headers' do
      expect(mail.subject).to eq I18n.t('user_mailer.confirmation.subject')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([Rails.application.secrets.email_username])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Seja bem vindo ao')
    end
  end

  describe 'password' do
    let(:user) { create(:user)}
    let(:mail) { UserMailer.password(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq I18n.t('user_mailer.password.subject')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([Rails.application.secrets.email_username])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Para redefinir sua senha clique no link abaixo')
    end
  end
end
