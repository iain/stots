module ApplicationHelper

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
