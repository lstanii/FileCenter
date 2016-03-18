Pod::Spec.new do |s|
  s.name               =  'FileCenter'
  s.version            =  '1.0.0'
  s.license            =  { :type => 'Apache 2.0' }
  s.summary            =  'An iOS framework for easy saving and retrieving files on a device.'
  s.description        =  'Use FileCenter to easily save, delete and access files on iOS devices. Elegantly create directories, save, read and download files!'
  s.homepage           =  'http://www.rebelcreators.com'
  s.author             =  { 'Rebel Creators.' => 'lstanii@nmsu.edu' }
  s.source             =  { :git => 'https://github.com/lstanii/FileCenter.git', :tag => "tag-filecenter-release-#{s.version}" }

  s.platform = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'src/**/*.swift'

  s.frameworks = 'Foundation'

  s.xcconfig       =  { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2', 'OTHER_LDFLAGS' => '-ObjC', 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES','ENABLE_BITCODE' => 'NO'}

end
