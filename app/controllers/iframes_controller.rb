class IframesController < InheritedResources::Base

  belongs_to :project

  actions :all, :except => :index

end
