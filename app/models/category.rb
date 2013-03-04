# encoding: UTF-8
class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id

  validates :name, :presence => {:message => "Názov kategórie nesmie byť prázdny."}

  has_ancestry :orphan_strategy => :destroy

  scope :with_name, lambda { |name| {:conditions => ['name LIKE ?', "%#{name}%"]} }

  def self.search(search)
    if search.blank?
      scoped
    else
      #TODO find path to root elements
      @categories = Category.with_name(search)
    end
  end
end
