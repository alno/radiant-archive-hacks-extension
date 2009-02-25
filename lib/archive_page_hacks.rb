# Hacking ArchivePage class
# Use groupping from Radiant::Config['archive.group'], default '%Y/%m'
# Don't use groupping for pages with slug, accepted by Radiant::Config['archive.nogroup'], default '\.(.*)'
module ArchivePageHacks

  def self.included(base)
    base.class_eval do
      alias_method_chain :find_by_url, :hacks
    end
  end

  # This method differs from original only by default value of last argument
  def find_by_url_with_hacks(url, live = true, clean = true)
    find_by_url_without_hacks(url, live, clean)
  end

  def child_url(child)
    date = child.published_at || Time.now

    if nogroup_slug = option_nogroup.match( child.slug )
      clean_url "#{ url }/#{ nogroup_slug[1] }"
    else
      clean_url "#{ url }/#{ date.strftime option_group }/#{ child.slug }"
    end
  end

  def option_group
    @@option_group ||= Radiant::Config['archive.group']
  end

  def option_nogroup
    @@option_nogroup ||= Regexp.new( Radiant::Config['archive.nogroup'] )
  end

end 
