Pod::Spec.new do |s|
  s.name         = "RKKiwiMatchers"
  s.version      = "0.20.3"
  s.summary      = "Provides a rich set of matchers for use in testing RestKit applications with the Kiwi Behavior Driven Development library."
  s.homepage     = "https://github.com/RestKit/RKKiwiMatchers"

  s.license      = { :type => 'Apache', :file => 'LICENSE'}

  s.author       = { "Blake Watters" => "blakewatters@gmail.com" }

  s.framework       = 'SenTestingKit'
  s.ios.xcconfig    = { 'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(SDKROOT)/Developer/Library/Frameworks" "$(DEVELOPER_LIBRARY_DIR)/Frameworks"' }
  s.osx.xcconfig    = { 'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(DEVELOPER_LIBRARY_DIR)/Frameworks"' }
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  s.requires_arc = true
  
  s.source       = { :git => "https://github.com/RestKit/RKKiwiMatchers.git", :tag => '0.20.0' }
  s.source_files = 'Code/*.{h,m}'
  
  # NOTE: The RestKit dependency is not specified within the Podspec because this pod is designed to be exclusively linked into the unit testing bundle target. Directly specifying RestKit causes the compilation of a secondary copy of the library.
  #s.dependency 'RestKit/Testing', '>= 0.20.0'
  s.dependency 'Kiwi', '>= 2.0.0'
  
  # Add Core Data to the PCH (This should be optional, but there's no good way to configure this with CocoaPods at the moment)
  s.prefix_header_contents = <<-EOS
#ifdef __OBJC__
#import <CoreData/CoreData.h>
#endif /* __OBJC__*/
EOS
end
