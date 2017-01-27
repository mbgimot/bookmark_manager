require 'spec_helper'

feature 'sign in' do
  before do
    sign_up
    sign_in
  end
  scenario 'user can sign in' do
    expect(current_path).to eq('/links')
  end
  scenario 'welcome message is displayed' do
    expect(page).to have_content('Welcome, test@test.com')
  end
end
