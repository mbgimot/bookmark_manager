require 'spec_helper'

feature 'sign up form' do
  scenario 'can sign up' do
    sign_up
    expect(current_path).to eq('/links')
    expect(page).to have_content("Welcome, test@test.com")
  end

  scenario 'signing up increases user count' do
    expect{sign_up}.to change{User.count}.by(1)
  end
  scenario "signing up with mismatched password throws an error" do
    expect{sign_up_false}.to change{User.count}.by(0)
  end
end
