module CategoriesHelper
  def nested_categories(categories)
      categories.map do |category, sub_categories|
        " - " + category.name + content_tag(:div, nested_categories(sub_categories), :class => "nested_categories")
      end.join.html_safe
  end
end
