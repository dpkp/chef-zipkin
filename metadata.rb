name             'zipkin'
maintainer       'Rdio, Inc.'
maintainer_email 'dana.powers@rd.io'
license          'Apache 2.0'
description      'Installs/Configures zipkin'
long_description 'Installs/Configures zipkin'
version          '0.0.1'

%w{ ubuntu }.each do |os|
  supports os
end

suggests 'sbt-extras'
suggests 'git'
suggests 'curl'
depends 'github'
depends 'java'
