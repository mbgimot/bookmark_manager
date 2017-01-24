require 'spec_helper'

feature "Viewing links" do
  scenario "displays a list of existing links" do
    Link.create(url: 'http://www.google.com', title: 'Google')

    visit ('/links')
    expect(page.status_code).to eq(200)

    within 'ul#links' do
      expect(page).to have_content("Google")
    end
    # expect(page).to have_link('', href: 'http://....')
  end
end
