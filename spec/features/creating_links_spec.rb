require 'spec_helper'

# As a time-pressed user
# So that I can save a website
# I would like to add the site's address and title to my bookmark manager
feature "Adding links" do
  scenario "add the site's address and title to my bookmark manager" do
    visit ('/links/new')
    url = rand(1000)
    title = rand(1000)
    fill_in 'url', with: url
    fill_in 'title', with: title
    click_button 'Create Link'

    within 'ul#links' do
      expect(page).to have_content(url)
      expect(page).to have_content(title)
    end
  end
end
