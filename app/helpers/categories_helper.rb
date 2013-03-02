module CategoriesHelper
  def nested_categories(categories, search)
      categories.map do |category, sub_categories|
        " - " + highlight(category.name, search, :ignore_special_chars => true) + content_tag(:div, nested_categories(sub_categories, search), :class => "nested_categories")
      end.join.html_safe
  end
end
