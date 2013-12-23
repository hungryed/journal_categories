require 'spec_helper'

feature 'User Creates New Category' do
  scenario 'User creates new category listing' do
    visit categories_path
    click_on 'Add Category'
    fill_in 'Name', with: 'Lobster'
    click_on 'Submit'
    expect(page).to have_content 'Category Added Successfully'
    expect(page).to have_content 'Lobster'
  end

  scenario 'User sees current categories' do
    category = FactoryGirl.create(:category)
    visit categories_path
    expect(page).to have_content category.name
  end

end
