require 'rails_helper'

RSpec.describe Restaurant, type: :model do

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    @user = User.create(email: "test@test.com", password: "testtest", password_confirmation: "testtest")
    @user.restaurants.create(name: 'The Scarecrow')
    restaurant = Restaurant.new(name: 'The Scarecrow')
    expect(restaurant).to have(1).error_on(:name)
  end

  it {should belong_to(:user)}

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        restaurant = Restaurant.create(name: 'The Ivy')
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end

    context 'multiple reviews' do
      it 'returns the average' do
        @user_one = User.create(email: "user.one@test.com", password: "testtest", password_confirmation: "testtest")
        @user_two = User.create(email: "user.two@test.com", password: "testtest", password_confirmation: "testtest")
        restaurant = Restaurant.create(name: 'The Ivy', user_id: @user_one.id)
        restaurant.reviews.create(rating: 1, user_id: @user_one.id)
        restaurant.reviews.create(rating: 5, user_id: @user_two.id)
        expect(restaurant.average_rating).to eq 3
        end
      end
    end

end
