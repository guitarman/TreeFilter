# encoding: UTF-8
class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id

  validates :name, :presence => {:message => "Názov kategórie nesmie byť prázdny."}

  has_ancestry

  def self.search(search)
    if search
      #TODO find path to root elements
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
