require 'spec_helper'

describe User do
  before do
    @user = User.new( email: "example_user@exampleemail.com",
                       password: "foobar",
                       password_digest: "foobar" )
  end

  subject { @user }

  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :password_digest }

  describe "when Email" do
    describe "is not presence" do
      before { @user.email = "" }
      it { should_not be_valid }
    end

    describe "format is invalid" do
      invalid_addresses = %w[ user@foo,com
                              user_at_foo.org
                              example.user@foo.
                              foo@bar_baz.com
                              foo@bar+baz.com
                            ]

      invalid_addresses.each do |invalid_address|
        before { @user.email = invalid_address }
        it { should_not be_valid }
      end
    end

    describe "format is valid" do
      valid_addresses = %w[ user@foo.COM
                            A_US-ER@f.b.org
                            first.last@foo.jp
                            a+b@baz.cn
                          ]

      valid_addresses.each do |valid_address|
        before { @user.email = valid_address }
        it { should be_valid }
      end
    end

    describe "is already taken" do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.email = @user.email.upcase
        user_with_same_email.save
      end

      it { should_not be_valid }
    end
  end

  describe "when Password" do
    describe "length is shorten than 6" do
      before do
        @user.password = "a" * 5
        @user.password_confirmation = "a" * 5
      end

      it { should_not be_valid }
    end
  end

  describe "when Active" do
    before do
      @user.save
    end

    its(:active) { should be false }
    its(:activation_token) { should_not be_empty }
  end
end
