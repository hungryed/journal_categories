require 'spec_helper'

feature 'User Creates New Category' do
  after(:all) { Category.destroy_all }
  scenario 'User creates new category listing' do
    visit categories_path
    click_on 'Add Category'
    fill_in 'Name', with: 'Lobster'
    click_on 'Submit'
    expect(page).to have_content 'Category Added Successfully'
    expect(page).to have_content 'Lobster'
  end

  scenario 'User cannot create multiple similar categories' do
    visit new_category_path
    fill_in 'Name', with: 'Kraken'
    click_on 'Submit'
    click_on 'Add Category'
    fill_in 'Name', with: 'Kraken'
    click_on 'Submit'
    expect(page).to have_content 'That category already exists'
  end

  scenario 'User sees current categories' do
    category = FactoryGirl.create(:category)
    visit categories_path
    expect(page).to have_content category.name
  end

  scenario 'User deletes existing category' do
    category = FactoryGirl.create(:category)
    visit categories_path
    click_on 'Delete'
    expect(page).to have_content 'Total Annihilation'
    expect(page).to_not have_content category.name
  end

end
