require 'rails_helper'
require_relative '../helpers/restaurants_helper_spec'
require_relative '../helpers/reviews_helper_spec'

feature 'Users can review restaurants' do
  before do
    signup_user1
    @user = User.find_by_email('test@example.com')
    @user.restaurants.create(name: 'Los pollos hermanos', description: 'beautiful')
    new_review
  end

  scenario 'by creating a review via a form' do
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'Although serving chicken, it is fishy'
  end

  context 'when deleting reviews' do
    scenario 'a delete button is displayed' do
      expect(page).to have_link('Delete Your Review')
    end

    scenario 'the user can delete its own review' do
      click_link('Delete Your Review')
      expect(page).not_to have_content('Although serving chicken, it is fishy')
    end
  end
end
