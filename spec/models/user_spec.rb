RSpec.describe User do
  before :each  do
    @attr = attributes_for(:user)
  end

  it "deve criar uma nova instância com atributos válidos" do
    User.create!(@attr)
  end

  it "deve requerer email" do
    no_email_user = User.new(@attr.merge(email: ""))
    expect(no_email_user).to_not be_valid
  end

  it "deve aceitar emails válidos" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(email: address))
      expect(valid_email_user).to be_valid
    end
  end

  it "deve rejeitar emails inválidos" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(email: address))
      expect(invalid_email_user).to_not be_valid
    end
  end

  it "deve rejeitar email duplicado" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).to_not be_valid
  end

  it "deve rejeitar email identico em maiúscula" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(email: upcased_email))
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).to_not be_valid
  end

  # it "deve retornar name com email" do
    # user = build(:user)
    # expect(user.name_email).to eq "#{user.name} (#{user.email})"
  # end

  context "passwords" do
    before :each do
      @user = User.new(@attr)
    end

    it "deve ter password" do
      expect(@user).to respond_to(:password)
    end

    it "deve ter password confirmation" do
      expect(@user).to respond_to(:password_confirmation)
    end
  end

  context "password validations" do
    it "deve requerer password" do
      expect(User.new(@attr.merge(password: "", password_confirmation: ""))).
        to_not be_valid
    end

    it "deve requerer password confirmation igual" do
      expect(User.new(@attr.merge(password_confirmation: "invalid"))).
        to_not be_valid
    end

    it "deve rejeitar password pequena" do
      short = "a" * 7
      hash = @attr.merge(password: short, password_confirmation: short)
      expect(User.new(hash)).to_not be_valid
    end

    it "deve aceitar tamanho mínimo de password" do
      minimo = "a" * 8
      hash = @attr.merge(password: minimo, password_confirmation: minimo)
      expect(User.new(hash)).to be_valid
    end
  end

  context "password encryption" do
    before :each do
      @user = User.create!(@attr)
    end

    it "deve ter encrypted password" do
      expect(@user).to respond_to(:encrypted_password)
    end

    it "deve setar encrypted password" do
      expect(@user.encrypted_password).to_not be_blank
    end
  end
end
