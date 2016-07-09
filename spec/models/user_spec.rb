RSpec.describe User do
  subject { build :user }

  # it { should respond_to(:email) }
  # it { should respond_to(:password) }
  # it { should respond_to(:password_confirmation) }
  # it { should respond_to(:authentication_token) }

  it { should be_valid }

  context 'associations' do
    # it { should have_many(:authentication).dependent(:delete_all) }
    it { should have_many(:peso).dependent(:delete_all) }
    it { should have_many(:result).dependent(:delete_all) }
  end

  context 'validations' do
    context 'email format' do
      context 'valid' do
        %w(a.b.c@example.com test_mail@gmail.com any@any.net email@test.br 13@mail.test).each do |email|
          it { should allow_value(email).for(:email) }
        end
      end

      context 'invalid' do
        %w(user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com).each do |email|
          it { should_not allow_value(email).for(:email) }
        end
      end
    end

    context 'length' do
      it { should validate_length_of(:email).is_at_most(255) }
      it { should validate_length_of(:password).is_at_least(8).is_at_most(72) }
    end

    context 'password_complexity' do
      context 'valid' do
        %w(` ~ ! @ # $ % ^ & * ( ) - _ = + [ ] { } \ | ; : ' " , . < > / ?).each do |extra_char|
          it { should allow_value("Senha12#{ extra_char }").for(:password) }
        end
      end

      context 'invalid' do
        %w(12345678 password =+[]{}\| PASSWORD password1 Password1 password_1).each do |password|
          it { should_not allow_value(password).for(:password) }
        end
      end
    end

    context 'presence' do
      it { should validate_presence_of(:date_of_birth) }
      it { should validate_presence_of(:gender) }
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:email) }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of(:authentication_token).allow_nil }
      it { should validate_uniqueness_of(:confirmation_token).allow_nil }
      it { should validate_uniqueness_of(:email).case_insensitive }
      it { should validate_uniqueness_of(:reset_password_token).allow_nil }
    end

    # it { should validate_confirmation_of(:password) }
  end

  context 'callbacks' do
    it 'email should be saved as lower-case' do
      user = create :user, email: 'EXAMPLE@EXamPLE.coM'
      expect(user.email).to eq 'example@example.com'
    end
  end

  context 'scopes' do
    it '.ordered' do
      users = []
      user = User.first
      users.push user.id if user
      users.push create(:user, current_sign_in_at: 2.days.ago).id
      users.push create(:user, current_sign_in_at: 3.day.ago).id
      expect(User.ordered.pluck(:id)).to eq users
    end

    it '.peso_ordered' do
      user = create :user
      peso = create :peso, user: user
      expect(user.peso_ordered).to eq [peso]
    end
  end

  # describe '#activate' do
  #   it 'change to true activate attribute' do
  #     @new_user = create :not_activate_user
  #
  #     expect(@new_user.activated).to be_falsey
  #     expect(@new_user.activated_at).to be_nil
  #
  #     @new_user.activate
  #
  #     expect(@new_user.activated).to be_truthy
  #     expect(@new_user.activated_at).not_to be_nil
  #   end
  # end

  # describe '#authenticated?' do
  #   before(:each) do
  #     @new_user = create :user
  #   end
  #
  #   it 'return false with invalid attribute' do
  #     expect(@new_user.authenticated?(:invalid, @new_user.activation_token)).to be_falsey
  #   end
  #
  #   it 'return false with invalid token' do
  #     expect(@new_user.authenticated?(:activation, 'invalid token')).to be_falsey
  #   end
  #
  #   it 'return true with valid token' do
  #     expect(@new_user.authenticated?(:activation, @new_user.activation_token)).to be_truthy
  #   end
  # end

  # describe '#create_reset_digest' do
  #   it 'generates a token' do
  #     user = create :user
  #     expect(user.reset_digest).to be_nil
  #     user.create_reset_digest
  #     expect(user.reset_digest).not_to be_nil
  #   end
  # end

  # describe '#generate_authentication_token!' do
  #   it 'generates a unique token' do
  #     allow(Devise).to receive(:friendly_token).and_return('auniquetoken123')
  #     @user.generate_authentication_token!
  #     expect(@user.authentication_token).to eql 'auniquetoken123'
  #   end
  #
  #   it 'generates another token when one already has been taken' do
  #     existing_user = create :user, authentication_token: 'auniquetoken123'
  #     @user.generate_token
  #     expect(@user.authentication_token).not_to eql existing_user.authentication_token
  #   end
  # end

  # describe '#send_activation_email' do
  #   it 'send link' do
  #     @new_user = create :not_activate_user
  #     @new_user.send_activation_email
  #
  #     expect(ActionMailer::Base.deliveries.size).to eq 1
  #   end
  # end

  # describe '#send_password_reset_email' do
  #   it 'send with link' do
  #     @new_user = create :not_activate_user
  #     @new_user.create_reset_digest
  #     @new_user.send_password_reset_email
  #
  #     expect(ActionMailer::Base.deliveries.size).to eq 2
  #   end
  # end

  # describe '#update_sign_in_information' do
  #   it 'updates last_sign_in_at with current_sign_in_at' do
  #     old_current_sign_in_at = 1.year.ago
  #     @user.current_sign_in_at = old_current_sign_in_at
  #     @user.last_sign_in_at = 2.year.ago
  #
  #     @user.update_sign_in_information
  #     expect(@user.last_sign_in_at).to eq old_current_sign_in_at
  #   end
  #
  #   it 'updates sign_in_count' do
  #     sign_in_count  = @user.sign_in_count
  #     @user.update_sign_in_information
  #     expect(@user.sign_in_count).to eq sign_in_count + 1
  #   end
  # end
end
