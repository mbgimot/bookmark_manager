require 'spec_helper'

feature 'sign up form' do

  context 'password verification' do
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
        expect(page).to have_content("Password does not match the confirmation")
      end

      scenario "shows original email address in sign up form" do
        sign_up_false
        expect(find_field('email').value).to eq('test@test.com')
      end
    end

    context "email address" do
      scenario "is empty" do
        expect{sign_up_empty_email}.to change{User.count}.by(0)
      end
      scenario "not to have invalid format" do
        #expect(find_field('email').value).to match([a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$)
        expect{sign_up_with_invalid_email}.to change{User.count}.by(0)
      end
      context "unique email" do
        scenario "should be unique" do
          expect{sign_up_twice}.to change{User.count}.by(1)
        end
        scenario "non unique email throws error" do
          sign_up_twice
          expect(page).to have_content("Email is already taken")
        end
      end
    end
  end


end
