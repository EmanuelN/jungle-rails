require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations:" do
    before do
      @user = User.create(
        first_name: "Emanuel",
        last_name: "Neves",
        password: "password",
        password_confirmation: "password",
        email: "test@test.com"
        )
    end

    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
    it { is_expected.to validate_presence_of :password_confirmation }
    it { is_expected.to validate_confirmation_of :password}

    context "failures:" do
      before do
        @user.password_confirmation="shouldntwork"
        @user.save
        @user2 = User.create(
          first_name: "Bob",
          last_name: "Nahman",
          password: "123",
          password_confirmation: "123",
          email: "test@test.COM"
          )
      end

      it "doesn't save if passwords don't match" do
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "doesn't save if email is same as other user" do
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end

      it "doesn't save if password is too weak" do
        expect(@user2.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(
        first_name: 'Bob',
        last_name: 'Adams',
        password: '1234567',
        password_confirmation: '1234567',
        email: 'test@test.com'
        )
    end

    it "returns nil if the user's email is wrong" do
      expect(User.authenticate_with_credentials("test@test.net", "1234567")).to eq(nil)
    end

    it "returns nil if the user's password is wrong" do
      expect(User.authenticate_with_credentials("test@test.com", '1234')).to eq(nil)
    end

    it "returns the user if the password is correct" do
      expect(User.authenticate_with_credentials("test@test.com", '1234567')).to eq(@user)
    end

  end

end
