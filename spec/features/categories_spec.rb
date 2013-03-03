# encoding: UTF-8
require 'spec_helper'

describe "Categories" do
  before :each do
    Category.create(:name => 'Topanky')
    category = Category.create(:name => 'Oblecenie')
    Category.create(:name => 'Nohavice', :parent_id => category.id)
  end

  describe "GET /categories" do
    it "display categories list" do
      visit root_path
      page.should have_content("Topanky")
      page.should have_content("Oblecenie")
      page.should have_content("Nohavice")
    end
  end

  describe "GET /categories" do
    it "displays search category, other catagories are not shown" do
      visit root_path
      fill_in "search", :with => "Topanky"
      click_button "Filtrovať"
      page.should have_content("Topanky")
      page.should_not have_content("Oblecenie")
      page.should_not have_content("Nohavice")
    end
  end

  describe "GET /categories" do
    it "displays notice for no record when searching nonexistent category" do
      visit root_path
      fill_in "search", :with => "fdgdhdshydt"
      click_button "Filtrovať"
      page.should have_content("Pre hľadaný výraz \"fdgdhdshydt\" neboli nájdené žiadne výsledky.")
    end
  end
end
