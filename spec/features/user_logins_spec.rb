require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @user = User.create(
      first_name: "Test",
      last_name: "McTestor",
      password: "test12345",
      password_confirmation: "test12345",
      email: "test@mctestor.com"
      )
  end

  scenario "User logging in" do
    # ACT
    visit root_path
    click_on "Login"

    fill_in "email", with: "test@mctestor.com"
    fill_in "password", with: "test12345"
    click_on "Submit"

    # DEBUG / VERIFY

    expect(page).to have_content "Test"
  end

end
