require 'rails_helper'

RSpec.feature "UserCreates", type: :feature do

  scenario "User logging in" do
    # ACT
    visit root_path
    click_on "Signup"

    fill_in "user[first_name]", with: "Test"
    fill_in "user[last_name]", with: "McTestor"
    fill_in "user[email]", with: "test@mctestor.com"
    fill_in "user[password]", with: "test12345"
    fill_in "user[password_confirmation]", with: "test12345"
    click_on "Submit"

    # DEBUG / VERIFY
    expect(page).to have_content "Test"
  end

  scenario "User creates account with missing params" do
    visit root_path

    click_on "Signup"
    fill_in "user[email]", with: "test@mctestor.com"
    click_on "Submit"

    expect(page).to have_content "error"
  end

end
