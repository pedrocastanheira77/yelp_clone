def new_review
  visit '/restaurants'
  click_link 'Review Los pollos hermanos'
  fill_in 'Thoughts', with: 'Although serving chicken, it is fishy'
  select '1', from: 'Rating'
  click_button 'Leave Review'
end
