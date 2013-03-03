# encoding: UTF-8
require 'spec_helper'

describe "Categories" do
  before :each do
    Category.create(:name => 'Topanky')
    category = Category.create(:name => 'Oblecenie')
    Category.create(:name => 'Nohavice', :parent_id => category.id)
  end

  describe "GET /categories" do
    it "displays categories list" do
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
    it "displays search category with parent" do
      visit root_path
      fill_in "search", :with => "Nohavice"
      click_button "Filtrovať"
      #save_and_open_page
      page.should have_content("Nohavice")
      page.should have_content("Oblecenie")
      page.should_not have_content("Topanky")
    end
  end

  describe "GET /categories" do
    it "displays results with correct hierarchy" do
      visit root_path
      fill_in "search", :with => "ce"
      click_button "Filtrovať"
      page.should have_xpath("//div[@class='nested_categories']", :text => "Nohavice")
    end
  end

  describe "GET /categories" do
    it "displays notice for no record, when searching nonexistent category" do
      visit root_path
      fill_in "search", :with => "Tricka"
      click_button "Filtrovať"
      page.should have_content("Pre hľadaný výraz \"Tricka\" neboli nájdené žiadne výsledky.")
    end
  end
end
