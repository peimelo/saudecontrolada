# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)      not null
#  gender                 :string(255)      not null
#  date_of_birth          :date             not null
#  admin                  :boolean          default(FALSE), not null
#

RSpec.describe User do
  it { expect(build(:user)).to be_valid }

  describe 'associations' do
    it { should have_many(:authentication).dependent(:delete_all) }
    it { should have_many(:peso).dependent(:delete_all) }
    it { should have_many(:resultado).dependent(:delete_all) }
  end

  describe 'validations' do
    it { should validate_presence_of(:date_of_birth) }
    it { should validate_presence_of(:gender) }
    it { should validate_presence_of(:name) }
  end

  describe 'validacoes do Devise' do
    before :each  do
      @attr = attributes_for(:user)
    end

    context 'email' do
      it 'deve requerer email' do
        no_email_user = User.new(@attr.merge(email: ''))
        expect(no_email_user).to_not be_valid
      end

      it 'deve aceitar emails válidos' do
        addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        addresses.each do |address|
          valid_email_user = User.new(@attr.merge(email: address))
          expect(valid_email_user).to be_valid
        end
      end

      it 'deve rejeitar emails inválidos' do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
        addresses.each do |address|
          invalid_email_user = User.new(@attr.merge(email: address))
          expect(invalid_email_user).to_not be_valid
        end
      end

      it 'deve rejeitar email duplicado' do
        User.create!(@attr)
        user_with_duplicate_email = User.new(@attr)
        expect(user_with_duplicate_email).to_not be_valid
      end

      it 'deve rejeitar email identico em maiúscula' do
        upcased_email = @attr[:email].upcase
        User.create!(@attr.merge(email: upcased_email))
        user_with_duplicate_email = User.new(@attr)
        expect(user_with_duplicate_email).to_not be_valid
      end
    end

    context 'passwords' do
      before :each do
        @user = User.new(@attr)
      end

      it 'deve ter password' do
        expect(@user).to respond_to(:password)
      end

      it 'deve ter password confirmation' do
        expect(@user).to respond_to(:password_confirmation)
      end
    end

    context 'password validations' do
      it 'deve requerer password' do
        expect(User.new(@attr.merge(password: '', password_confirmation: ''))).
          to_not be_valid
      end

      it 'deve requerer password confirmation igual' do
        expect(User.new(@attr.merge(password_confirmation: 'invalid'))).
          to_not be_valid
      end

      it 'deve rejeitar password pequena' do
        short = 'a' * 7
        hash = @attr.merge(password: short, password_confirmation: short)
        expect(User.new(hash)).to_not be_valid
      end

      it 'deve aceitar tamanho mínimo de password' do
        minimo = 'a' * 8
        hash = @attr.merge(password: minimo, password_confirmation: minimo)
        expect(User.new(hash)).to be_valid
      end
    end

    context 'password encryption' do
      before :each do
        @user = User.create!(@attr)
      end

      it 'deve ter encrypted password' do
        expect(@user).to respond_to(:encrypted_password)
      end

      it 'deve setar encrypted password' do
        expect(@user.encrypted_password).to_not be_blank
      end
    end
  end

  describe '.from_omniauth' do
    it 'usuario ja foi criado via provider' do
      user = create(:user)
      auth = create(:authentication, user: user)
      expect(User.from_omniauth(auth, user)).to eq user
    end

    it 'usuario existente antes e retornado pelo provider' do
      user = create(:user)
      auth = build(:authentication, user: nil)
      expect(User.from_omniauth(auth, user)).to eq user
    end

    it 'usuario criado atraves do provider' do
      auth = Hash.new
      auth['provider'] = 'github'
      auth['uid'] = '123'
      auth['info'] = Hash.new
      auth['info']['email'] = 'email@email.com'
      auth['info']['name'] = 'name'

      expect(User.from_omniauth(auth, nil)).to_not be_persisted
    end
  end

  describe '#idade' do
    it 'nascido a 30 anos atras' do
      expect(build(:user).idade).to eq 30
    end
  end
end
