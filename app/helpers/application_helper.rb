module ApplicationHelper
  def page_title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Hoowenware").join(" - ")
      end
    end 
  end
  
  def admins_only(&block)
    block.call if current_user.try(:admin?)
  end
  
  def authorized?(permission, thing, &block)
    block.call if can?(permission.to_sym, thing) || current_user.try(:admin?)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end