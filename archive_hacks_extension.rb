require_dependency 'application'

class ArchiveHacksExtension < Radiant::Extension
  version "1.0"
  description "Some hacks for standart archive extensions, improving its usability"
  url "http://github.com/alno/radiant-archive-hacks-extension"
    
  def activate

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

      # Fixing placement archive as root page

      alias_method :old_find_by_url, :find_by_url

      # This method differs from original only by default value of last argument
      def find_by_url(url, live = true, clean = true)
        old_find_by_url(url, live, clean)
      end

    end

  end
  
  def deactivate
  end
  
end