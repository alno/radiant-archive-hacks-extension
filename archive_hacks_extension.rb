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

    # Hacking ArchivePage class
    # Use groupping from Radiant::Config['archive.group'], default '%Y/%m'
    # Don't use groupping for pages with slug, accepted by Radiant::Config['archive.nogroup'], default '\.(.*)'
    ArchivePage.class_eval do # Hacking ArchivePage class

      def child_url(child)
        date = child.published_at || Time.now

        if nogroup_slug = option_nogroup.match( child.slug )
          clean_url "#{ url }/#{ nogroup_slug[1] }"
        else
          clean_url "#{ url }/#{ date.strftime option_group }/#{ child.slug }"
        end
      end

      def option_group
        Radiant::Config['archive.group'] || Radiant::Config['archive.group'] = '%Y/%m'
      end

      def option_nogroup
        Regexp.new( "^#{Radiant::Config['archive.nogroup'] || Radiant::Config['archive.nogroup'] = '\.(.*)'}$" )
      end

    end
  end
  
  def deactivate
    # admin.tabs.remove "Archive Hacks"
  end
  
end