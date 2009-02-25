class ArchiveHacksExtension < Radiant::Extension
  version "1.0"
  description "Some hacks for standart archive extension, improving it usability"
  url "https://github.com/alno/radiant-archive-hacks-extension/"
    
  def activate
    Radiant::Config['archive.group'] = '%Y/%m/%d' unless Radiant::Config['archive.group']
    Radiant::Config['archive.nogroup'] = '^\.(.+)$' unless Radiant::Config['archive.nogroup']

    ArchivePage.send :include, ArchivePageHacks # Hacking ArchivePage class
  end
  
  def deactivate
  end
  
end