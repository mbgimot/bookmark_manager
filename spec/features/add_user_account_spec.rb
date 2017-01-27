require 'spec_helper'

feature 'sign up form' do

  context 'password matches' do
    scenario 'can sign up' do
      sign_up
      expect(current_path).to eq('/links')
      expect(page).to have_content("Welcome, test@test.com")
    end

    scenario 'signing up increases user count' do
      expect{sign_up}.to change{User.count}.by(1)
    end
  end

  context "mismatched password" do
    scenario "doesn't add a user" do
      expect{sign_up_false}.to change{User.count}.by(0)
    end

    scenario "leaves user on /users page" do
      sign_up_false
      expect(current_path).to eq('/users/new')
    end

    scenario "throws an error message" do
      sign_up_false
      expect(page).to have_content("Your passwords do not match!")
    end

    scenario "shows original email address in sign up form" do
      sign_up_false
      expect(find_field('email').value).to eq('test@test.com')
    end
  end
end
