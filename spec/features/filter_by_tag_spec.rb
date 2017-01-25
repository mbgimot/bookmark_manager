require 'spec_helper'

feature "Filtering tags" do
  scenario "filters website links by tags" do
    visit ('/links/new')
    add_bubbles_link
    click_button 'Add Link'
    add_random_link
    click_button 'Filter'
    fill_in 'search_tag', with: 'bubbles'
    click_button 'Search'

    within 'ul#links' do
      expect(page).to have_content('Google')
      expect(page).not_to have_content('test.com')
    end
  end
end
