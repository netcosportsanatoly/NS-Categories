Pod::Spec.new do |s|
  s.name             = "NS-Categories"
  s.version          = "1.1.6"
  s.summary          = "The open source Categories from Netco Sports"
  s.homepage         = "https://github.com/netcosports/NS-Categories"
  s.license          = 'The MIT License (MIT)'
  s.author           = { "Netco Sports" => "ios@netcosports.com" }
  s.source           = { :git => "https://github.com/netcosports/NS-Categories.git", :tag => s.version }
  s.social_media_url = 'https://twitter.com/netcosports'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Extends'

  s.frameworks = 'UIKit', 'Security'
  s.libraries = 'z'

  s.module_name = 'NSCategories'
end
