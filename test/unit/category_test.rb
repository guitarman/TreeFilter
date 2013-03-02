# encoding: UTF-8
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "should create category" do
    category = Category.new
    category.name = "Prislusenstvo"
    assert category.save
  end

  test "should not create a category without name" do
    category = Category.new
    assert !category.valid?
    assert category.errors[:name].any?
    assert_equal ["Názov kategórie nesmie byť prázdny."], category.errors[:name]
    assert !category.save
  end

  test "should create category as a child of existing category" do
    category = Category.new
    category.name = "Tricka"
    category.parent_id = categories(:oblecenie).id
    assert category.save
  end

  test "should find category" do
    category_id = categories(:oblecenie).id
    assert_nothing_raised { Category.find(category_id) }
  end

  test "should find category using category model search method" do
    category_name = categories(:oblecenie).name
    searched_categories = Category.search(category_name)
    assert_not_nil(searched_categories)
    assert_equal(searched_categories[0], categories(:oblecenie))
  end

  test "should update category" do
    category = categories(:rukavice)
    assert category.update_attributes(:name => 'Rukavice')
  end

  test "should destroy category" do
    category = categories(:rukavice)
    category.destroy
    assert_raise(ActiveRecord::RecordNotFound) { Category.find(category.id) }
  end

  test "should destroy children categories after deleting parent category" do
    category = Category.new
    category.name = "Nohavice"
    category.parent_id = categories(:oblecenie).id
    category.save
    category_id = category.id
    assert_nothing_raised { Category.find(category_id) }
    cat_oblecenie_id = categories(:oblecenie).id
    categories(:oblecenie).destroy
    assert_raise(ActiveRecord::RecordNotFound) { Category.find(cat_oblecenie_id) }
    assert_raise(ActiveRecord::RecordNotFound) { Category.find(category_id) }
  end
end
