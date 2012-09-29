Pod::Spec.new do |s|
  s.name         = "RKKiwiMatchers"
  s.version      = "0.1.0"
  s.summary      = "Provides a rich set of matchers for use in testing RestKit applications with the Kiwi Behavior Driven Development library."
  s.homepage     = "https://github.com/RestKit/RKKiwiMatchers"

  s.license      = { :type => 'Apache', :file => 'LICENSE'}

  s.author       = { "Blake Watters" => "blakewatters@gmail.com" }

  s.platform     = :ios, '5.0'
  s.requires_arc = true
  
  s.source       = { :git => "https://github.com/RestKit/RKKiwiMatchers.git", :tag => '0.1.0' }
  s.source_files = 'Code/*.{h,m}'
  
  # s.dependency 'RestKit', '>= 0.20.0'
  s.dependency 'Kiwi', '~> 1.1.0'
end
