Pod::Spec.new do |s|
  s.name         = "RKKiwiMatchers"
  s.version      = "0.20.0"
  s.summary      = "Provides a rich set of matchers for use in testing RestKit applications with the Kiwi Behavior Driven Development library."
  s.homepage     = "https://github.com/RestKit/RKKiwiMatchers"

  s.license      = { :type => 'Apache', :file => 'LICENSE'}

  s.author       = { "Blake Watters" => "blakewatters@gmail.com" }

  s.platform     = :ios, '5.0'
  s.requires_arc = true
  
  s.source       = { :git => "https://github.com/RestKit/RKKiwiMatchers.git", :branch => 'master' }
  s.source_files = 'Code/*.{h,m}'
  
  # NOTE: The RestKit dependency is not specified within the Podspec because this pod is designed to be exclusively linked into the unit testing bundle target. Directly specifying RestKit causes the compilation of a secondary copy of the library.
  #s.dependency 'RestKit/Testing', '>= 0.20.0pre4'
  s.dependency 'Kiwi', '~> 1.1.0'
end
