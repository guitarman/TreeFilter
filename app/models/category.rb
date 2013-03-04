# encoding: UTF-8
class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id

  validates :name, :presence => {:message => "Názov kategórie nesmie byť prázdny."}

  has_ancestry :orphan_strategy => :destroy

  scope :with_name, lambda { |name| {:conditions => ['name LIKE ?', "%#{name}%"]} }
  scope :with_ids, lambda { |ids| {:conditions => {:id => ids } } }

  def self.search(search)
    if search.blank?
      scoped
    else
      #TODO join @categories and @parents
      @categories = Category.with_name(search)

      parents_ids = []
      children_ids = []

      #find all parents ids and children ids
      @categories.each do |category|
        ancestry = category.ancestry
        parents_ids += ancestry.split("/") unless ancestry.nil?
        children_ids << category.id.to_s
      end

      if parents_ids.any?
        #make parent_ids unique
        parents_ids.uniq!
        #delete parents, which were already found via search parameter
        parents_ids = parents_ids - children_ids
        #select all unique missing parents
        @parents = Category.with_ids(parents_ids)

        #join @parents and @categories
      end

      @categories
    end
  end
end
