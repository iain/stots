module ApplicationHelper

  def caret
    content_tag(:b, "", :class => "caret")
  end

  def data(type, value=nil)
    { :data => { type => (value || type) } }
  end

  def active_when(logic, extra_class="")
    if logic
      { :class => "active #{extra_class}" }
    else
      { :class => extra_class }
    end
  end

end
