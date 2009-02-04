# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ArchiveHacksExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/archive_hacks"
  
  # define_routes do |map|
  #   map.connect 'admin/archive_hacks/:action', :controller => 'admin/archive_hacks'
  # end
  
  def activate
    # admin.tabs.add "Archive Hacks", "/admin/archive_hacks", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Archive Hacks"
  end
  
end