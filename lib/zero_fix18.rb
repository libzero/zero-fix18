# Only add patches, if Ruby version is below 1.9, to prevent breaking things
if RUBY_VERSION <= '1.9'

  require 'patches/uri'

end