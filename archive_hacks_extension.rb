require_dependency 'application'

class ArchiveHacksExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://github.com/alno/radiant-archive-hacks-extension"
  
  # define_routes do |map|
  #   map.connect 'admin/archive_hacks/:action', :controller => 'admin/archive_hacks'
  # end
  
  def activate
    # admin.tabs.add "Archive Hacks", "/admin/archive_hacks", :after => "Layouts", :visibility => [:all]

    ArchivePage.class_eval do # Hacking ArchivePage class

      # Use groupping from Radiant::Config
      def child_url(child)
        date = child.published_at || Time.now
        clean_url "#{ url }/#{ date.strftime archive_groupping }/#{ child.slug }"
      end

      def archive_groupping        
        Radiant::Config['archive.groupping'] || Radiant::Config['archive.groupping'] = '%Y/%m'
      end

    end
  end
  
  def deactivate
    # admin.tabs.remove "Archive Hacks"
  end
  
end